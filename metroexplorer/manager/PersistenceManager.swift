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
    
    func saveLandmark(landmark: Landmark) {
        let userDefaults = UserDefaults.standard
        
        var landmarks = fetchLandmarks()
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
    
    func deleteLandmark(id: String){
        let userDefaults = UserDefaults.standard
        
        var landmarks = fetchLandmarks()
        
//        for lm in landmarks {
//            if lm.id == id {
//                let index1 = landmarks.index { $0.id == id}
//            }
//        }
//        landmarks.remove(at: index1)
    }
}
