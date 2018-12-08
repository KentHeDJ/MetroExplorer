//
//  Landmark.swift
//  metroexplorer
//
//  Created by Dejian He on 12/8/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import Foundation

class Landmark: Codable {
    let name: String
    let image: String
    let address: String
    let rating: String
    
    init(name: String, image: String, address: String, rating: String) {
        self.name = name
        self.image = image
        self.address = address
        self.rating = rating
    }
}
