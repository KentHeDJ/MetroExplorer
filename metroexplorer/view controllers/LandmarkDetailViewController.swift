//
//  LandmarkDetailViewController.swift
//  metroexplorer
//
//  Created by Dejian He on 12/9/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import UIKit

class LandmarkDetailViewController: UIViewController {
    
    var image:String? = nil
    var id:String = ""
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
        
        if let imageUrlString = image, let url = URL(string: imageUrlString) {
            landmarkImage.load(url: url)
        }
        
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        
        let shareText = "Hello! Please check this wonderful landmark: \n Name: \(name) \n Address: \(address) \n Rating: \(rating)!!!"
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let landmark = Landmark(id: id, name: name, image: image, address: address, rating: rating)
        PersistenceManager.sharedInstance.saveLandmark(landmark: landmark)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        let landmark = Landmark(id: id, name: name, image: image, address: address, rating: rating)
        PersistenceManager.sharedInstance.deleteLandmark(id: landmark.id)
    }
    
}
