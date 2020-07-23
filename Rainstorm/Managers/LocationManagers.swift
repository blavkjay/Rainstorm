//
//  LocationManagers.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 22/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager:NSObject, LocationService{
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    
    private var didFetchLocation: FetchLocationCompletion?
    
    func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
        didFetchLocation = completion
        locationManager.requestLocation()
    }
    
}


extension LocationManager: CLLocationManagerDelegate{
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to fetch location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
        }else if status == .authorizedWhenInUse{
            locationManager.requestLocation()
        }else{
            
            let result: LocationServiceResult = .failure(.notAuthorizedToRequestLocation)
            didFetchLocation?(result)
            didFetchLocation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let result: LocationServiceResult = .success(Location(location:location))
        didFetchLocation?(result)
        didFetchLocation = nil
    }
}


fileprivate extension Location{
    init(location: CLLocation) {
        longitude = location.coordinate.longitude
        latitude = location.coordinate.latitude
    }
}
