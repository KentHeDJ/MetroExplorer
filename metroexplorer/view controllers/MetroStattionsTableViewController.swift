//
//  MetroStattionsTableViewController.swift
//  metroexplorer
//
//  Created by Dejian He on 12/8/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import UIKit
import MBProgressHUD

class MetroStattionsTableViewController: UITableViewController {
    
    var index = 1
    
    var metroStations = [MetroStation]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchMetroStationsManage = FetchMetroStationsManager()
        fetchMetroStationsManage.delegate = self
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        fetchMetroStationsManage.fetchMetroStations()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return metroStations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "metroStationCell", for: indexPath) as! MetroStationTableViewCell
        
        let metroStation = metroStations[indexPath.row]
        
        cell.metroStationNameLabel.text = metroStation.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        print("metro station click")
        performSegue(withIdentifier: "landmarkSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is LandmarksTableViewController
        {
            let vc = segue.destination as? LandmarksTableViewController
            vc?.latitude = metroStations[index].latitude
            vc?.longitude = metroStations[index].longitude
            vc?.fromMetro = true
        }
    }

}

extension MetroStattionsTableViewController: FetchMetroStationsDelegate {
    func metroStationsFound(_ metroStations: [MetroStation]) {
        print("metro stations found - here they are in the controller")
        
        DispatchQueue.main.async {
            self.metroStations = metroStations
            
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func metroStationsNotFound() {
        print("no metro stations found")
        
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
