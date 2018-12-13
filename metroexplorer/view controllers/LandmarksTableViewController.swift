//
//  LandmarksTableViewController.swift
//  metroexplorer
//
//  Created by Dejian He on 12/8/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import UIKit
import MBProgressHUD
import CoreLocation

class LandmarksTableViewController: UITableViewController {
    let fetchLandmarksManager = FetchLandmarksManager()
    let locationDetector = LocationDetector()
    let fetchMetroStationsManage = FetchMetroStationsManager()
    
    var index = 1
    var flag:Bool = false
    var latitude: Double = 0
    var longitude: Double = 0
    var fromMetro:Bool = false
    var metroTitle: String = ""
    
    var metroStations = [MetroStation]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var landmarks = [Landmark]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let favoritesLandmarks = PersistenceManager.sharedInstance.fetchLandmarks()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLandmarksManager.delegate = self
        locationDetector.delegate = self
        fetchMetroStationsManage.delegate = self
        
        if flag == false {
            fetchMetroStationsManage.fetchMetroStations()
        }
        
        //distinguish from nearest button or metro stastion list screen
        if fromMetro == true {
            fetchLandmarksManager.fetchLandmarks(latitude: latitude, longitude: longitude)
        }
        else {
            fetchLandmarks()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    private func fetchLandmarks() {
        //loading dialog
        MBProgressHUD.showAdded(to: self.view, animated: true)
        //get current location
        locationDetector.findLocation()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //distingguish from nearest button or favorites button
        if flag == false {
            return landmarks.count
        } else {
            return favoritesLandmarks.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "landmarkCell", for: indexPath) as! LandmarkTableViewCell
        
        if flag == true {
            //from favorites button
            let favoritesLandmark = favoritesLandmarks[indexPath.row]
            
            //displaied information
            cell.landmarkNameLabel.text = favoritesLandmark.name
            cell.landmarkAddressLabel.text = favoritesLandmark.address
            
            if let imageUrlString = favoritesLandmark.image, let url = URL(string: imageUrlString) {
                cell.landmarkImage.load(url: url)
            }
            
        } else {
            //from nearest button
            let landmark = landmarks[indexPath.row]
            
            //displaied information
            cell.landmarkNameLabel.text = landmark.name
            cell.landmarkAddressLabel.text = landmark.address
            
            if let imageUrlString = landmark.image, let url = URL(string: imageUrlString) {
                cell.landmarkImage.load(url: url)
            }
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //mark the index of cell
        index = indexPath.row
        
        //direct to landmark detail screen
        print("landmark detail cell click")
        performSegue(withIdentifier: "landmarkDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is LandmarkDetailViewController && flag == false
        {
            //from nearest
            let vc = segue.destination as? LandmarkDetailViewController
            //pass data to detail page
            vc?.id = landmarks[index].id
            vc?.name = landmarks[index].name
            vc?.address = landmarks[index].address
            vc?.rating = landmarks[index].rating
            vc?.image = landmarks[index].image ?? ""
        } else {
            //from favorite
            let vc = segue.destination as? LandmarkDetailViewController
            //pass data to detail page
            vc?.id = landmarks[index].id
            vc?.name = favoritesLandmarks[index].name
            vc?.address = favoritesLandmarks[index].address
            vc?.rating = favoritesLandmarks[index].rating
            vc?.image = favoritesLandmarks[index].image ?? ""
        }
    }

}

extension LandmarksTableViewController: LocationDetectorDelegate {
    func locationDetected(latitude: Double, longitude: Double) {
        
        //current lcoation
        let coordinate1 = CLLocation(latitude: latitude, longitude: longitude)
        var distance:Double = 100000
        var targetLat:Double = 0
        var targetLon:Double = 0
        
        //compare with the distance to all the metro stations in list and get the nearest one
        for metrostation in metroStations {
            let coordinate2 = CLLocation(latitude: metrostation.latitude, longitude: metrostation.longitude)
            let metroDistance = coordinate1.distance(from: coordinate2)
            if metroDistance < distance {
                distance = metroDistance
                targetLat = metrostation.latitude
                targetLon = metrostation.longitude
                metroTitle = metrostation.name
            }
        }
        
        //set metro station name to the screen title
        self.title = "Station: " + metroTitle
        
        fetchLandmarksManager.fetchLandmarks(latitude: targetLat, longitude: targetLon)
    }
    
    func locationNotDetected() {
        print("no location found")
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

extension LandmarksTableViewController: FetchLankmarksDelegate {
    func landmarksFound(_ landmarks: [Landmark]) {
        print("landmarks found - here they are in the controller")
        
        DispatchQueue.main.async {
            self.landmarks = landmarks
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func landmarksNotFound(reason: FetchLandmarksManager.FailureReason) {
        
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            
            //display alert to user when probem comes up
            let alertController = UIAlertController(title: "Problem fetching landmarks", message: reason.rawValue, preferredStyle: .alert)
            
            //provide retry option for user
            switch(reason) {
            case .noResponse:
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    self.fetchLandmarks()
                })
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler:nil)
                
                alertController.addAction(cancelAction)
                alertController.addAction(retryAction)
                
            case .non200Response, .noData, .badData:
                let okayAction = UIAlertAction(title: "Okay", style: .default, handler:nil)
                
                alertController.addAction(okayAction)
            }
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension LandmarksTableViewController: FetchMetroStationsDelegate {
    func metroStationsFound(_ metroStations: [MetroStation]) {
        print("metro stations found - here they are in the controller")
        
        DispatchQueue.main.async {
            self.metroStations = metroStations

        }
    }
    
    func metroStationsNotFound() {
        print("no metro stations found")

    }
}
