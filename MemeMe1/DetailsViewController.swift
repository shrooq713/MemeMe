//
//  DetailsViewController.swift
//  MemeMe1
//
//  Created by Areej Ali on 21/09/1440 AH.
//  Copyright © 1440 Shrooq Saleh. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imView: UIImageView!
    var VCImage : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        imView.image = VCImage
    }

}
