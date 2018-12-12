//
//  LocationDetector.swift
//  metroexplorer
//
//  Created by Dejian He on 12/12/18.
//  Copyright © 2018 Dejian He. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationDetectorDelegate {
    func locationDetected(latitude: Double, longitude: Double)
    func locationNotDetected() //no GPS/network signal for 5 seconds (timeout) OR no permission
    
}

class LocationDetector: NSObject {
    
    let locationManager = CLLocationManager()
    
    var delegate: LocationDetectorDelegate?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func findLocation() {
        let permissionStatus = CLLocationManager.authorizationStatus()
        
        switch(permissionStatus) {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            delegate?.locationNotDetected()
        case .denied:
            delegate?.locationNotDetected()
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        }
    }
}

extension LocationDetector: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //do something with the locaiton
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            
            delegate?.locationDetected(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //handle the error
        print(error.localizedDescription)
        delegate?.locationNotDetected()
    }
    
    // this gets call after user accepts OR denies permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //handle this
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        else {
            delegate?.locationNotDetected()
        }
    }
    
}
