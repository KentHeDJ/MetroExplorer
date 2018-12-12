//
//  FetchLandmarksManager.swift
//  metroexplorer
//
//  Created by Dejian He on 12/9/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import Foundation

protocol  FetchLankmarksDelegate {
    func landmarksFound(_ landmarks: [Landmark])
    func landmarksNotFound()
}

class FetchLandmarksManager {
    
    var delegate: FetchLankmarksDelegate?
    
    func fetchLandmarks(latitude: Double, longitude: Double) {
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: "landmarks"),
            URLQueryItem(name: "location", value: "DC"),
//            URLQueryItem(name: "latitude", value: "\(latitude)"),
//            URLQueryItem(name: "longitude", value: "\(longitude)")
        ]
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer YCC9Y2FX6vKa_8eNF6urS9xLNo4nxc8P3bCqKL_S0t0hcMCr7M0jOcMgWkf0c8z3iSJf6ypDKFVxMkL4mKkCfbttOhxqAXDeA1WugS1xNhtKnrBOTLRfGIy1WdAMXHYx", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            print("request complete")
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("response is nil or 200")
                
                self.delegate?.landmarksNotFound()
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data else {
                print("data is nil")
                
                self.delegate?.landmarksNotFound()
                
                return
            }
            
            //HERE - data is NOT nil
            
            let decoder = JSONDecoder()
            
            do {
                let yelpResponse = try decoder.decode(YelpResponse.self, from: data)
                
                //HERE - decoding was successful
                
                var landmarks = [Landmark]()
                
                for business in yelpResponse.businesses {
                    //let name = business.name
                    let address = business.location.displayAddress.joined(separator: " ")
                    
                    let landmark = Landmark(id: business.id, name: business.name, image: business.imageUrl, address: address, rating: business.rating)
                    
                    landmarks.append(landmark)
                }
                
                print(landmarks)
                
                self.delegate?.landmarksFound(landmarks)
                
            } catch let error {
                print("codable fail - bad data format")
                print(error.localizedDescription)
                
                self.delegate?.landmarksNotFound()
            }
            
        }
        
        print("execute request")
        task.resume()
    }
}
