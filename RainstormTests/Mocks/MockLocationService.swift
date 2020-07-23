//
//  MockLocationService.swift
//  RainstormTests
//
//  Created by OLAJUWON BALOGUN on 22/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation

@testable import Rainstorm

class MockLocationService: LocationService{
    
    var location: Location? = Location(latitude: 0.0, longitude: 0.0)

    var delay: TimeInterval = 0.0
    
    func fetchLocation(completion: @escaping FetchLocationCompletion) {
        let result : LocationServiceResult
        if let location = location{
            result = .success(location)
        }else{
            result = .failure(.notAuthorizedToRequestLocation)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+delay){
            completion(result)
        }
    }
    
    
    
}
