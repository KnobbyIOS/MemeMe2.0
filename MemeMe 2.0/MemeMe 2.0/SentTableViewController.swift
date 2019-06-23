//
//  SentTableViewController.swift
//  MemeMe 2.0
//
//  Created by Brian Leding on 4/30/19.
//  Copyright © 2019 Brian Leding. All rights reserved.
//

import Foundation
import UIKit

class SentTableViewController: UITableViewController {
    

    var memes = [Meme]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")!
        let tempMeme = self.memes[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = (tempMeme.topText + " " + tempMeme.bottomText)
        cell.imageView?.image = tempMeme.memedImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        //Populate view controller with data from the selected item
       detailController.meme = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
        
    }

    
}

