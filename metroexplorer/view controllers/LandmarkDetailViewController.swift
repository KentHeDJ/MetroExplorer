//
//  LandmarkDetailViewController.swift
//  metroexplorer
//
//  Created by Dejian He on 12/9/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import UIKit

class LandmarkDetailViewController: UIViewController {
    
    var image:URL = URL(fileURLWithPath: "")
    var name:String = ""
    var address:String = ""
    var rating:Double = 0

    @IBOutlet weak var landmarkImage: UIImageView!
    @IBOutlet weak var landmarkNameLabel: UILabel!
    @IBOutlet weak var landmarkAddressLabel: UILabel!
    @IBOutlet weak var landmarkRatingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        landmarkNameLabel?.text = name
        landmarkAddressLabel?.text = address
        landmarkRatingLabel?.text = String(rating)
        landmarkImage.load(url: image)
    }
    

}
