//
//  FetchLandmarksManager.swift
//  metroexplorer
//
//  Created by Dejian He on 12/9/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import Foundation

class FetchLandmarksManager {
    
    func fetchLandmarks() {
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: "landmarks"),
            URLQueryItem(name: "location", value: "DC"),
        ]
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer YCC9Y2FX6vKa_8eNF6urS9xLNo4nxc8P3bCqKL_S0t0hcMCr7M0jOcMgWkf0c8z3iSJf6ypDKFVxMkL4mKkCfbttOhxqAXDeA1WugS1xNhtKnrBOTLRfGIy1WdAMXHYx", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            print("request complete")
//            print(data)
//            print(response)
//            print(error)
            
        }
        
        print("execute request")
        task.resume()
    }
}
