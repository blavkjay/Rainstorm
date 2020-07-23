//
//  DayViewModel.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 21/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation
import UIKit

struct DayViewModel{
    let weatherData: CurrentWeatherConditions
    
    private let dateFormatter = DateFormatter()
    
    var date: String{
        dateFormatter.dateFormat = "EEE, MMMM d YYYY"
        return dateFormatter.string(from: weatherData.time)
    }
    
    var time: String{
         dateFormatter.dateFormat = "HH:MM a"
         return dateFormatter.string(from: weatherData.time)
     }
    var summary: String{
        return weatherData.summary
    }
    
    var temperature: String{
        return String(format: "%.1f F", weatherData.temperature)
    }
    
    var windSpeed: String{
        return String(format: "%.f MPH",weatherData.windSpeed)
    }
    
    var image: UIImage?{
        return UIImage.imageForIcon(with: weatherData.icon)
    }
    
}
