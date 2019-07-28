//
//  MemeTableViewController.swift
//  MemeMe1
//
//  Created by Areej Ali on 17/09/1440 AH.
//  Copyright © 1440 Shrooq Saleh. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes: [Meme]!{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as! MemeTableViewCell
        cell.poster.image = memes[indexPath.row].memedImage
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme = memes[indexPath.row]
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController
        
        //Populate view controller with data from the selected item
        //  detailController.imageView = meme.memedImage
        detailController.VCImage = meme.memedImage
        // Present the view controller using navigation
        navigationController?.pushViewController(detailController, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    @IBAction func add(_ sender: Any){
        let addMeme = self.storyboard!.instantiateViewController(withIdentifier: "ViewController")
        navigationController!.pushViewController(addMeme, animated: true)
        
    }
    @IBAction func unwind(_ sender: UIStoryboardSegue) {}
}
