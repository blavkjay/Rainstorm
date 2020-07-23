//
//  Configuration.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 11/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation


enum Defaults{
    static let location = Location(latitude: 37.335114 , longitude: -122.008928)
}

enum Configuration{
    static var refreshThreshold: TimeInterval{
        #if DEBUG
        return 60.0
        #else
        return 60.0 * 10.0
        #endif
    }
}

enum WeatherService{
    private static let apiKey = "f574c275ab31a264ea69d4ffea0fde52"
    private static let baseUrl = URL(string: "https://api.darksky.net/forecast/")!
    static var authenticatedUrl: URL{
        return baseUrl.appendingPathComponent(apiKey)
    }
}
