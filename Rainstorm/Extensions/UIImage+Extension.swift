//
//  UIImage+Extension.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 21/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    class func imageForIcon(with name: String) -> UIImage?{
        switch name {
        case "clear-day",
             "clear-night",
             "fog",
             "rain",
             "snow",
             "sleet",
             "wind":
            return UIImage(named: name)
            case "cloudy",
                 "partly-cloudy-day",
                 "partly-cloudy-night":
            return UIImage(named: "cloudy")
        default:
            return UIImage(named: "clear-day")
        }
    }
}
