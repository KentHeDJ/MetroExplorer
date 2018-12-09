//
//  YelpResponse.swift
//  metroexplorer
//
//  Created by Dejian He on 12/9/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import Foundation

struct YelpResponse: Codable {
    
    let businesses: [Businesses]
    let total: Int
    let region: Region
    
}

struct Businesses: Codable {
    
    let id: String
    let alias: String
    let name: String
    let imageUrl: URL
    let isClosed: Bool
    let url: URL
    let reviewCount: Double
    let categories: [Categories]
    let rating: Double
    let coordinates: Coordinates
    //let transactions: [Any] // TODO: Please provide a codable type, because Any isn't one.
    let location: Location
    let phone: String
    let displayPhone: String
    let distance: Double
    
    private enum CodingKeys: String, CodingKey {
        case id
        case alias
        case name
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories
        case rating
        case coordinates
        //case transactions
        case location
        case phone
        case displayPhone = "display_phone"
        case distance
    }
}

struct Categories: Codable {
    
    let alias: String
    let title: String
    
}

struct Coordinates: Codable {
    
    let latitude: Double
    let longitude: Double
    
}

struct Location: Codable {
    
    let address1: String?
    let address2: String?
    let address3: String?
    let city: String
    let zipCode: String
    let country: String
    let state: String
    let displayAddress: [String]
    
    private enum CodingKeys: String, CodingKey {
        case address1
        case address2
        case address3
        case city
        case zipCode = "zip_code"
        case country
        case state
        case displayAddress = "display_address"
    }
}

struct Region: Codable {
    
    let center: Center
    
}

struct Center: Codable {
    
    let longitude: Double
    let latitude: Double
    
}




