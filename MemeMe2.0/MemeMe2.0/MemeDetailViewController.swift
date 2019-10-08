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
    
    
    @IBOutlet weak var memedImage: UIImageView!
    
    var meme: Meme!



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memedImage.image = meme.memedImage
        memedImage.contentMode = .scaleAspectFit
        
    }
    
    
    
    
}
