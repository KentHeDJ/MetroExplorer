//
//  LandmarksTableViewController.swift
//  metroexplorer
//
//  Created by Dejian He on 12/8/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import UIKit

class LandmarksTableViewController: UITableViewController {
    
    var index = 1
    var flag:Bool = false
    var latitude: Double = 34.900599
    var longitude: Double = -79.050273
    
    var landmarks = [Landmark]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let favoritesLandmarks = PersistenceManager.sharedInstance.fetchLandmarks()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchLandmarksManager = FetchLandmarksManager()
        fetchLandmarksManager.delegate = self
        fetchLandmarksManager.fetchLandmarks(latitude: latitude, longitude: longitude)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
            let favoritesLandmark = favoritesLandmarks[indexPath.row]
            
            cell.landmarkNameLabel.text = favoritesLandmark.name
            cell.landmarkAddressLabel.text = favoritesLandmark.address
            cell.landmarkImage.load(url: favoritesLandmark.image)
        } else {
            let landmark = landmarks[indexPath.row]
            
            cell.landmarkNameLabel.text = landmark.name
            cell.landmarkAddressLabel.text = landmark.address
            cell.landmarkImage.load(url: landmark.image)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        
        print("landmark detail cell click")
        performSegue(withIdentifier: "landmarkDetailSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is LandmarkDetailViewController && flag == false
        {
            let vc = segue.destination as? LandmarkDetailViewController
            vc?.id = landmarks[index].id
            vc?.name = landmarks[index].name
            vc?.address = landmarks[index].address
            vc?.rating = landmarks[index].rating
            vc?.image = landmarks[index].image
        } else {
            let vc = segue.destination as? LandmarkDetailViewController
            vc?.id = landmarks[index].id
            vc?.name = favoritesLandmarks[index].name
            vc?.address = favoritesLandmarks[index].address
            vc?.rating = favoritesLandmarks[index].rating
            vc?.image = favoritesLandmarks[index].image
        }
    }
    


}

extension LandmarksTableViewController: FetchLankmarksDelegate {
    func landmarksFound(_ landmarks: [Landmark]) {
        print("landmarks found - here they are in the controller")
        self.landmarks = landmarks
        //tableView.reloadData()
    }
    
    func landmarksNotFound() {
        print("no landmarks found")
    }
}
