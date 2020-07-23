//
//  RootViewModel.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 11/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation
import CoreLocation

class RootViewModel: NSObject{
    
    enum WeatherDataError: Error{
        case noWeatherDataAvailable
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
    }
    
    enum WeatherDataResult{
        case success(WeatherData)
        case failure(WeatherDataError)
    }
    
    typealias FetchWeatherDataCompletion = (WeatherDataResult) -> Void
    var didFetchWeatherData: FetchWeatherDataCompletion?
    
    
  
    private var networkService: NetworkService
    private var locationService: LocationService
    
    init(networkService: NetworkService,locationService: LocationService){
        self.locationService = locationService
        self.networkService = networkService
        super.init()
        setupNotificationHandling()
    }
    
    private func fetchLocation(){
        locationService.fetchLocation { [weak self] (result) in
            
            
            switch result{
            case .success(let location):
                 self?.fetchWeatherData(for: location)
            case .failure(let error):
                print("Unable to fetch location \(error)")
                let result : WeatherDataResult = .failure(.notAuthorizedToRequestLocation)
                self?.didFetchWeatherData?(result)
            }
        }
        
    }
    private func fetchWeatherData(for location: Location){
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedUrl, location: location)
        
        
        networkService.fetchData(with:weatherRequest.url){[weak self](data, response, error) in
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            DispatchQueue.main.async {
                if let error = error{
                    print("Unable to fetch weather data \(error)")
                    let result : WeatherDataResult = .failure(.noWeatherDataAvailable)
                    self?.didFetchWeatherData?(result)
                }else if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    do{
                        let darkSkyResponse = try decoder.decode(DarkSkyResponse.self, from: data)
                        let result: WeatherDataResult = .success(darkSkyResponse)
                        UserDefaults.didFetchWeatherData = Date()
                        self?.didFetchWeatherData?(result)
                    }catch{
                        print("Unable to decode response \(error)")
                        let result : WeatherDataResult = .failure(.noWeatherDataAvailable)
                        self?.didFetchWeatherData?(result)
                    }
                }else {
                     let result : WeatherDataResult = .failure(.noWeatherDataAvailable)
                     self?.didFetchWeatherData?(result)
                }
            }
            
            
        }
    }

    private func setupNotificationHandling(){
        NotificationCenter.default.addObserver(forName: Notification.Name.NSExtensionHostWillEnterForeground,
                                               object: nil,
                                               queue: OperationQueue.main) {[weak self] (_) in
                                                
                                                guard let diFetchWeatherData = UserDefaults.didFetchWeatherData else{
                                                    self?.refresh()
                                                    return
                                                }
                                                if Date().timeIntervalSince(diFetchWeatherData) >  Configuration.refreshThreshold{
                                                    self?.refresh()
                                                }
        }
    }
    
     func refresh(){
        fetchLocation()
    }
    
}


extension UserDefaults{
    private enum Keys{
        static let didFetchWeatherData = "didFetchWeatherData"
    }
    
    fileprivate class var didFetchWeatherData: Date?{
        get{
            return UserDefaults.standard.object(forKey: Keys.didFetchWeatherData) as? Date
        }
        
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Keys.didFetchWeatherData)
        }
    }
}
