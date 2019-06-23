//
//  MemeDetail.swift
//  MemeMe 2.0
//
//  Created by Brian Leding on 6/8/19.
//  Copyright © 2019 Brian Leding. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController, UITableViewDelegate, UIImagePickerControllerDelegate {
    

    var meme: Meme!
    
    @IBOutlet weak var memedImaged: UIImageView!
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memedImaged.image = meme.memedImage
        memedImaged.contentMode = .scaleAspectFit
        
    }
    
    
    
    
}
