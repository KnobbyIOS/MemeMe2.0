//
//  EditorViewController.swift
//  MemeMe 2.0
//
//  Created by Brian Leding on 4/30/19.
//  Copyright © 2019 Brian Leding. All rights reserved.
//



import Foundation
import UIKit


class EditorViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    //DECLARATIONS
    
    var memes = [Meme]()
    
    let pickerController = UIImagePickerController()
    
    var cameraButton = UIImagePickerController()
    
    var memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -6
    ]
    
    //OUTLETS
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet var cameraButtonEnabler: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButtonEnabler: UIBarButtonItem!
    @IBOutlet weak var toolBarEnabler: UIToolbar!
    @IBOutlet weak var navigationBarEnabler: UINavigationItem!
    
    //ACTIONS
    
    @IBAction func pickAnImage(_ sender: Any)                   // function defined below to open the image picker to select an image
    {
        chooseImageSource(source: .photoLibrary)
        
    }
    @IBAction func pickAnImageFromCamera(_ sender: Any)
    {
        
        chooseImageSource(source: .camera)
        
    }
    
    @IBAction func topTextFieldEditor(_ sender: Any) {
        
        if topTextField.text == "TOP" {
            topTextField.text = ""
        }
        
    }
    
    @IBAction func bottomTestFieldEditor(_ sender: Any) {
        
        if bottomTextField.text == "BOTTOM" {
            bottomTextField.text = ""
        }
    }
    
    @IBAction func cancelSelection()  {
        
        
        setDefaultText()
        imagePickerView?.image = nil
        shareButtonEnabler.isEnabled = false
  
    }
    
    @IBAction func shareMeme() {
        
        let meme = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {(activity, completed, items, error) in
            if (!completed)
            {
                return
            }
            else
            {
                self.save(memedImage: meme)            }
            print("Success! Your meme has been saved!")
            self.startOver()
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // FUNCTIONS
    
    override func viewWillAppear(_ animated: Bool)
    {
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.center
        bottomTextField.textAlignment = NSTextAlignment.center
        subscribeToKeyboardNotifications()
        
        //check to see if camera is available to enable or disable Camera button
        
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            cameraButtonEnabler.isEnabled = true
        } else {
            cameraButtonEnabler.isEnabled = false
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setDefaultTextAttributes(tF: topTextField)
        setDefaultTextAttributes(tF: bottomTextField)
        setDefaultText()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        shareButtonEnabler.isEnabled = false
        toolBarEnabler.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func setDefaultTextAttributes(tF: UITextField)
    {
        
        tF.defaultTextAttributes = memeTextAttributes
        tF.textColor = UIColor.white
        tF.tintColor = UIColor.white
        tF.textAlignment = NSTextAlignment.center
        tF.delegate = self
        
        
    }
    func setDefaultText()
    {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
    }
    
    func chooseImageSource(source: UIImagePickerController.SourceType)  {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
        {
            imagePickerView?.image = image  // sets the image in the UI Image View through the iboutlet
            dismiss(animated: true, completion: nil)
            shareButtonEnabler.isEnabled = true
        }
        
    }
    
    func startOver(){
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
        
    {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func keyboardWillChange(notification:Notification) {
        
        if notification.name == UIResponder.keyboardWillShowNotification && self.bottomTextField.isEditing ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification && self.bottomTextField.isEditing{
            let offset = 0 - getKeyboardHeight(notification)
            view.frame.origin.y = offset
        } else {
            view.frame.origin.y = 0
        }
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func generateMemedImage() -> UIImage {
        
        self.navigationController?.setNavigationBarHidden(true , animated: false)
        toolBarEnabler.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        toolBarEnabler.isHidden = false
        return memedImage
        
    }
    
    //Create Meme struct and add to array of memes
    
    func save(memedImage: UIImage)
    {
        
        let tempMeme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        
        appDelegate.memes.append(tempMeme)
        
    }

    deinit {
        print("View Controller Deallocated")
    }
}
