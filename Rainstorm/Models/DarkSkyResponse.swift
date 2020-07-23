//
//  DarkSkyResponse.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 12/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation


struct DarkSkyResponse: Codable{
    
    let latitude: Double
    let longitude: Double
    let currently: Conditions
    let daily: Daily
    
    struct Conditions: Codable{
        let time: Date
        let icon: String
        let windSpeed: Double
        let summary: String
        let temperature: Double
    }
    
    struct Daily: Codable{
        let data: [Conditions]
        
        struct Conditions: Codable {
            let time: Date
            let icon: String
            let windSpeed: Double
            let temperatureMin: Double
            let temperatureMax: Double
        }
        
    }
}


extension DarkSkyResponse: WeatherData{
    var current: CurrentWeatherConditions {
        return currently
    }
    
    var forecast: [ForecastWeatherConditions] {
        return daily.data
    }
}

extension DarkSkyResponse.Conditions: CurrentWeatherConditions{

}

extension DarkSkyResponse.Daily.Conditions: ForecastWeatherConditions{

}
