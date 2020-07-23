//
//  WeekDayTableViewCell.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 22/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {

    
    static var reuseIdentifier: String{
        return String(describing: self)
    }
    
    //MARK: - properties
    
    @IBOutlet var dayLabel: UILabel!{
        didSet{
            dayLabel.textColor = UIColor.RainStorm.baseTextColor
            dayLabel.font = UIFont.RainStorm.heavyLarge
        }
    }
    
    
    @IBOutlet var dateLabel: UILabel!{
        didSet{
            dateLabel.textColor = .black
            dateLabel.font = UIFont.RainStorm.lightRegular
        }
    }
    
    @IBOutlet var windSpeedLabel: UILabel!{
        didSet{
            windSpeedLabel.textColor = .black
            windSpeedLabel.font = UIFont.RainStorm.lightSmall
        }
    }
    
    @IBOutlet var temperatureLabel: UILabel!{
        didSet{
            temperatureLabel.textColor = .black
            temperatureLabel.font = UIFont.RainStorm.lightSmall
        }
    }
    
    @IBOutlet var iconImageView: UIImageView!{
        didSet{
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = UIColor.RainStorm.baseTintColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configure(with representable: WeekDayRepresentable){
        dayLabel.text = representable.day
        dateLabel.text = representable.date
        iconImageView.image = representable.image
        windSpeedLabel.text = representable.windSpeed
        temperatureLabel.text = representable.temperature
    }

}
