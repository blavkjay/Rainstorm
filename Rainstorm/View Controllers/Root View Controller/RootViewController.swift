//
//  RootViewController.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 11/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController, WeekViewControllerDelegate {
    func controllerDidRefresh(_ controller: WeekViewController) {
        viewModel?.refresh()
    }
    
    
    private enum AlertType{
        case noWeatherDataAvailable
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
    }
    
    //MARK: - properties
    var viewModel : RootViewModel? {
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            setUpViewModel(with: viewModel)
        }
    }
    
    private let dayViewController: DayViewController = {
        guard let dayViewController = UIStoryboard.main.instantiateViewController(identifier: DayViewController.storyboardIdentifier) as? DayViewController else{
            fatalError("Unable to instantiate Day view controller")
        }
        dayViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return dayViewController
    }()
    
    private lazy var weekViewController: WeekViewController = {
           guard let weekViewController = UIStoryboard.main.instantiateViewController(identifier: WeekViewController.storyboardIdentifier) as? WeekViewController else{
               fatalError("Unable to instantiate Day view controller")
           }
           weekViewController.delegate = self
           weekViewController.view.translatesAutoresizingMaskIntoConstraints = false
       
        
           return weekViewController
       }()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup child view controller
       setUpChildViewController()
        viewModel?.refresh()
    }
    
    
        //MARK:- helper method
    private func setUpChildViewController(){
        addChild(dayViewController)
        addChild(weekViewController)
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        dayViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dayViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dayViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        weekViewController.view.topAnchor.constraint(equalTo: dayViewController.view.bottomAnchor).isActive = true
        weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        dayViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    
    private func setUpViewModel(with viewModel:RootViewModel){
        viewModel.didFetchWeatherData = { [weak self] (result) in
            
            switch result {
            case .success(let weatherData):
                let dayViewModel = DayViewModel(weatherData: weatherData.current)
                self?.dayViewController.viewModel = dayViewModel
                let weakViewModel = WeekViewModel(weatherData: weatherData.forecast)
                self?.weekViewController.viewModel = weakViewModel
            case .failure(let error):
                let alertType : AlertType
                switch error{
                case .notAuthorizedToRequestLocation:
                    alertType = .notAuthorizedToRequestLocation
                case .failedToRequestLocation:
                    alertType = .failedToRequestLocation
                case .noWeatherDataAvailable:
                    alertType = .noWeatherDataAvailable
                }
                self?.presentAlert(of: alertType)
                self?.dayViewController.viewModel = nil
                self?.weekViewController.viewModel = nil
            }
        }
    }
    
    private func presentAlert(of alertType: AlertType){
        let title: String
        let message: String
        
        switch alertType {
        case .noWeatherDataAvailable:
            title = "Unable to fetch weather data"
            message = "The application is unable to fetch weather data. please make sure your device is connected to Wi-Fi or cellular"
        case .notAuthorizedToRequestLocation:
            title = "Unable to fetch weather data for your location"
            message = "Rain storm isn't authorized to access your current location. this means you can access weather conditions"
        case .failedToRequestLocation:
            title = "Unable to fetch weather data for your location"
            message = "Rain storm isn't authorized to access your current location. this means you can access weather conditions"
            
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController,animated: true)
    }
    
}

