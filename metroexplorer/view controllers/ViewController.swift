//
//  ViewController.swift
//  metroexplorer
//
//  Created by Dejian He on 11/26/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flag:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func nearestButtonPressed(_ sender: Any) {
        print("nearest pressed")
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
            vc?.flag = true
        }
        
    }
}

