//
//  WeekDayRepresentable.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 22/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import UIKit

protocol WeekDayRepresentable {
    var day: String { get }
    var date: String { get }
    var temperature: String { get }
    var windSpeed: String { get }
    var image: UIImage? { get }
}
