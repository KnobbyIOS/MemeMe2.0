//
//  CustomCell.swift
//  MemeMe 2.0
//
//  Created by Brian Leding on 6/14/19.
//  Copyright © 2019 Brian Leding. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var imageSpot: UIImageView!
    
    
    func setCell(meme: Meme) {
        imageSpot.image = meme.memedImage
        cellLabel.text = (meme.topText + " " + meme.bottomText)
    }
}
