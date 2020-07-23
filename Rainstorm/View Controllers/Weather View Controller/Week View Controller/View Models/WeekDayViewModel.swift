//
//  WeekDayViewModel.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 22/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import UIKit


struct WeekDayViewModel{
    let weatherData: ForecastWeatherConditions
    
    private let dateFormatter = DateFormatter()
    
    var day: String{
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: weatherData.time)
    }
    
    var date: String{
           dateFormatter.dateFormat = "MMMM d"
           return dateFormatter.string(from: weatherData.time)
       }
    
    var temperature: String{
        let min = String(format: "%.1f", weatherData.temperatureMin)
        let max = String(format: "%.1f", weatherData.temperatureMax)
        
        return "\(min) - \(max)"
    }
    
    var windSpeed: String{
        return String(format: "%.f MPH", weatherData.windSpeed)
    }
    
    var image: UIImage?{
        return UIImage.imageForIcon(with: weatherData.icon)
    }
}

extension WeekDayViewModel: WeekDayRepresentable{
    
}
