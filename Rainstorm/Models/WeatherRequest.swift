//
//  WeatherRequest.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 11/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation


struct WeatherRequest {
    let baseUrl: URL
    let location:  Location
    private var longitude: Double{
        return location.longitude
    }
    private var latitude: Double{
        return location.latitude
    }
    
    var url: URL{
        return baseUrl.appendingPathComponent("\(latitude),\(longitude)")
    }
}
