//
//  ViewController.swift
//  metroexplorer
//
//  Created by Dejian He on 11/26/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var flag:Bool = false
    var locationManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction func nearestButtonPressed(_ sender: Any) {
        print("nearest pressed")
        
        //idnetify from nearest
        flag = false
        performSegue(withIdentifier: "favoritesSegue", sender: self)
    }
    
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        print("favorites pressed")
        flag = true
        performSegue(withIdentifier: "favoritesSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is LandmarksTableViewController && flag == true
        {
            let vc = segue.destination as? LandmarksTableViewController
            //identify from favorites
            vc?.flag = true
        }
        
    }
}

