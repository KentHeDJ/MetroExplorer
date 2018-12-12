//
//  Landmark.swift
//  metroexplorer
//
//  Created by Dejian He on 12/8/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import Foundation

struct Landmark: Codable {
    let id: String
    let name: String
    let image: URL
    let address: String
    let rating: Double
}
