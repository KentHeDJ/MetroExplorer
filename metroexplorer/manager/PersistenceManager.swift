//
//  PersistenceManager.swift
//  metroexplorer
//
//  Created by Dejian He on 12/8/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let sharedInstance = PersistenceManager()
    
    let landmarksKey = "landmarks"
    
    //avoid repeated lankmark saved
    func saveLandmark(landmark: Landmark) {
        let userDefaults = UserDefaults.standard
        
        var landmarks = fetchLandmarks()
        
        for lm in landmarks {
            if lm.name == landmark.name {
                return
            }
        }
        landmarks.append(landmark)
        
        
        let encoder = JSONEncoder()
        let encodedLandmarks = try? encoder.encode(landmarks)
        
        userDefaults.set(encodedLandmarks, forKey: landmarksKey)
    }
    
    func fetchLandmarks() -> [Landmark] {
        let userDefaults = UserDefaults.standard
        
        if let landmarkData = userDefaults.data(forKey: landmarksKey), let landmarks = try? JSONDecoder().decode([Landmark].self, from: landmarkData) {
            //landmarkData is non-nil and successfully decoded
            return landmarks
        }
        else {
            return [Landmark]()
        }
    }
    
    func deleteLandmark(name: String){
        let userDefaults = UserDefaults.standard
        
        var landmarks = fetchLandmarks()
        
        //retrive index of certain landmark
        for (index, element) in landmarks.enumerated() {
            if element.name == name {
                landmarks.remove(at: index)
            }
        }
        
        let encoder = JSONEncoder()
        let encodedLandmarks = try? encoder.encode(landmarks)
        
        userDefaults.set(encodedLandmarks, forKey: landmarksKey)
        
    }
}
