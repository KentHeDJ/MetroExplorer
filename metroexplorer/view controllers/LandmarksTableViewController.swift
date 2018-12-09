//
//  LandmarksTableViewController.swift
//  metroexplorer
//
//  Created by Dejian He on 12/8/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import UIKit

class LandmarksTableViewController: UITableViewController {
    
    var landmarks = [Landmark]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let fetchLandmarksManager = FetchLandmarksManager()
        fetchLandmarksManager.delegate = self
        fetchLandmarksManager.fetchLandmarks()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return landmarks.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "landmarkCell", for: indexPath) as! LandmarkTableViewCell
        
        let landmark = landmarks[indexPath.row]

        cell.landmarkNameLabel.text = landmark.name
        cell.landmarkAddressLabel.text = landmark.address
        cell.landmarkImage.load(url: landmark.image)

        return cell
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
