//
//  SentCollectionViewController.swift
//  MemeMe2.0
//
//  Created by Brian Leding on 6/23/19.
//  Copyright © 2019 Brian Leding. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SentCollectionViewController: UICollectionViewController {
    
    var memes = [Meme]()
    
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        self.collectionView?.reloadData()
        
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.memes.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection Cell", for: ((indexPath as NSIndexPath) as IndexPath)) as! CustomCell
        let meme = memes[indexPath.row]
        cell.setCell(meme: meme)
        return cell
    
    }


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        //Populate view controller with data from the selected item
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
        
    }

    func setupFlowLayout() -> Void {
        
        let space: CGFloat = 3.0
        let horDim = (view.frame.width - (2 * space)) / 3.0
        let vertDim = (view.frame.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: horDim, height: vertDim)
    }
}
