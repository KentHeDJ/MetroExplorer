//
//  MetroStattionsTableViewController.swift
//  metroexplorer
//
//  Created by Dejian He on 12/8/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import UIKit

class MetroStattionsTableViewController: UITableViewController {
    
    var metroStations = [MetroStation]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchMetroStationsManage = FetchMetroStationsManager()
        fetchMetroStationsManage.delegate = self
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

}

extension MetroStattionsTableViewController: FetchMetroStationsDelegate {
    func metroStationsFound(_ metroStations: [MetroStation]) {
        print("metro stations found - here they are in the controller")
        self.metroStations = metroStations
    }
    
    func metroStationsNotFound() {
        print("no metro stations found")
    }
}
