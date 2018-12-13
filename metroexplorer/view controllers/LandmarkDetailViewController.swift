//
//  LandmarkDetailViewController.swift
//  metroexplorer
//
//  Created by Dejian He on 12/9/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import UIKit
import CoreLocation

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
        
        //display landmark detail
        landmarkNameLabel?.text = "Name: " + name
        landmarkAddressLabel?.text = "Address: " + address
        landmarkRatingLabel?.text = "Rate: " + String(rating)
        
        if let imageUrlString = image, let url = URL(string: imageUrlString) {
            landmarkImage.load(url: url)
        }
        
    }
    
    //share function
    @IBAction func shareButtonPressed(_ sender: Any) {
        
        let shareText = "Hello! Please check this wonderful landmark: \n Name: \(name) \n Address: \(address) \n Rating: \(rating)!!!"
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    //favor landmark
    @IBAction func saveButtonPressed(_ sender: Any) {
        let landmark = Landmark(id: id, name: name, image: image, address: address, rating: rating)
        PersistenceManager.sharedInstance.saveLandmark(landmark: landmark)
    }
    
    //unfavor lanmark
    @IBAction func deleteButtonPressed(_ sender: Any) {
        let landmark = Landmark(id: id, name: name, image: image, address: address, rating: rating)
        PersistenceManager.sharedInstance.deleteLandmark(name: landmark.name)
    }
    
    //public transpotation direction from current spot to landmark address
    @IBAction func directionButtonPressed(_ sender: Any) {
        print("direction button click")
        let landmark = Landmark(id: id, name: name, image: image, address: address, rating: rating)
        //pre-processing url format
        let daddr = landmark.address.replacingOccurrences(of: " ", with: "+")
        
        let url = "http://maps.apple.com/t=r&daddr=\(daddr)"
        guard let openUrl = URL(string: url) else {
            return
        }
        //open url
        UIApplication.shared.open(openUrl, options: [:], completionHandler: nil)
    }
}


