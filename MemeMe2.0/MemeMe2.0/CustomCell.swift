//
//  CustomCell.swift
//  MemeMe2.0
//
//  Created by Brian Leding on 6/23/19.
//  Copyright © 2019 Brian Leding. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    

    @IBOutlet weak var imageSpot: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    func setCell(meme: Meme) {
        imageSpot.image = meme.memedImage
        cellLabel.text = (meme.topText + " " + meme.bottomText)
    }
}
