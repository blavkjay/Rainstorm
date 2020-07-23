//
//  WeekViewModel.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 21/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation

struct WeekViewModel{
    let weatherData: [ForecastWeatherConditions]
    
    var numberOfDays: Int{
        return weatherData.count
    }
    
    func viewModel(for index: Int) -> WeekDayViewModel{
        return WeekDayViewModel(weatherData: weatherData[index])
    }
}
