//
//  DayViewController.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 11/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import UIKit

final class DayViewController: UIViewController {

    var viewModel: DayViewModel? {
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            setUpViewModel(with: viewModel)
        }
    }
    
    //MARK: -
    
    @IBOutlet var dateLabel: UILabel! {
        didSet{
            dateLabel.textColor = UIColor.RainStorm.baseTextColor
                dateLabel.font = UIFont.RainStorm.heavyLarge
    }
    }
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var iconImageView : UIImageView!{
        didSet{
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = UIColor.RainStorm.baseTintColor
        }
    }
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var regularLabels: [UILabel]!{
        didSet{
            for label in regularLabels{
                label.textColor =  UIColor.RainStorm.baseTextColor
                label.font = UIFont.RainStorm.lightRegular
            }
        }
    }
    
    @IBOutlet var smallLabels: [UILabel]!{
        didSet{
            for label in smallLabels{
                label.textColor =  UIColor.RainStorm.baseTextColor
                label.font = UIFont.RainStorm.lightSmall
            }
        }
    }
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!{
        didSet{
            activityIndicatorView.stopAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    @IBOutlet var weatherDataViews: [UIView]!{
        didSet{
            for view in weatherDataViews{
                view.isHidden = true
            }
        }
    }
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    //MARK: - Helper method
    private func setUpView(){
        //configure view
        view.backgroundColor = UIColor.RainStorm.lightBackgroundColor
    }
    
    private func setUpViewModel(with viewModel: DayViewModel){
        activityIndicatorView.stopAnimating()
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        windSpeedLabel.text = viewModel.windSpeed
        temperatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.summary
        iconImageView.image = viewModel.image
        
        for view in weatherDataViews{
            view.isHidden = false
        }
    }
    
}
