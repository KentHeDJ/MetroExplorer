//
//  FetchMetroStationsManager.swift
//  metroexplorer
//
//  Created by Dejian He on 12/9/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import Foundation

protocol FetchMetroStationsDelegate {
    func metroStationsFound(_ metroStations: [MetroStation])
    func metroStationsNotFound()
}

class FetchMetroStationsManager {
    
    var delegate: FetchMetroStationsDelegate?
    
    func fetchMetroStations() {
        var urlComponents = URLComponents(string: "https://api.wmata.com/Rail.svc/json/jStations")!
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("4976f2ac55f54942ae2bf9b508db3da0", forHTTPHeaderField: "api_key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            print("request complete")
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("response is nil or 200")
                
                self.delegate?.metroStationsNotFound()
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data else {
                print("data is nil")
                
                self.delegate?.metroStationsNotFound()
                
                return
            }
            
            //HERE - data is NOT nil
            
            let decoder = JSONDecoder()
            
            do {
                let wmataResponse = try decoder.decode(WMATAResponse.self, from: data)
                
                //HERE - decoding was successful
                
                var metroStations = [MetroStation]()
                
                for station in wmataResponse.Stations {
                    
                    let name = station.Name
                    let latitude = station.Lat
                    let longitude = station.Lon
                    
                    let metroStation = MetroStation(name: name, latitude: latitude, longitude: longitude)
                    
                    metroStations.append(metroStation)
                }
                
                print(metroStations)
                
                self.delegate?.metroStationsFound(metroStations)
                
            } catch let error {
                print("codable fail - bad data format")
                print(error.localizedDescription)
                
                self.delegate?.metroStationsNotFound()
            }
            
        }
        
        print("execute request")
        task.resume()
    }
}
