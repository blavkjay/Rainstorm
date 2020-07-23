//
//  RootViewModelTests.swift
//  RainstormTests
//
//  Created by OLAJUWON BALOGUN on 22/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import XCTest
@testable import Rainstorm

class RootViewModelTests: XCTestCase {

    var viewModel: RootViewModel!
    var locationService: MockLocationService!
    var networkService: MockNetworkService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let networkService = MockNetworkService()
        networkService.data = loadStub(name: "darksky", extension: "json")
        locationService = MockLocationService()
        viewModel = RootViewModel(networkService: networkService,locationService: MockLocationService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
         UserDefaults.standard.removeObject(forKey: "didFetchWeatherData")
    }
    
    func testRefresh_Success(){
        
        let expectation = XCTestExpectation(description: "Fetch weather data")
        
        viewModel.didFetchWeatherData = { (result) in
            if case .success(let weatherdata) = result {
                
                XCTAssertEqual(weatherdata.longitude, -122.4233)
                XCTAssertEqual(weatherdata.latitude, 37.8267)
                print(weatherdata)
                expectation.fulfill()
            }
            
        }
        viewModel.refresh()
        wait(for: [expectation], timeout: 2.0)
    }

    func testRefresh_failedTofetchLocation(){
        locationService.location = nil
         let expectation = XCTestExpectation(description: "Fetch weather data")
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                
                XCTAssertEqual(error, RootViewModel.WeatherDataError.notAuthorizedToRequestLocation)
                expectation.fulfill()
            }
            
        }
        viewModel.refresh()
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_failedToFetchWeatherData_RequestFailed(){
        
        networkService.error = NSError(domain: "com.Rainstorm.network.service", code: 1, userInfo: nil)
         let expectation = XCTestExpectation(description: "Fetch weather data")
      viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                
                XCTAssertEqual(error, RootViewModel.WeatherDataError.notAuthorizedToRequestLocation)
                expectation.fulfill()
            }
            
        }
        viewModel.refresh()
        wait(for: [expectation], timeout: 2.0)
    }
   
    func testRefresh_FailedToFetchWeatherData_InvalidResponse(){
        networkService.data = "data".data(using: .utf8)
           let expectation = XCTestExpectation(description: "Fetch weather data")
        viewModel.didFetchWeatherData = { (result) in
              if case .failure(let error) = result {
                  
                  XCTAssertEqual(error, RootViewModel.WeatherDataError.notAuthorizedToRequestLocation)
                  expectation.fulfill()
              }
              
          }
          viewModel.refresh()
          wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_FailedToFetchWeatherData_NoErrorNoResponse(){
        networkService.data = nil
                  let expectation = XCTestExpectation(description: "Fetch weather data")
               viewModel.didFetchWeatherData = { (result) in
                     if case .failure(let error) = result {
                         
                         XCTAssertEqual(error, RootViewModel.WeatherDataError.notAuthorizedToRequestLocation)
                         expectation.fulfill()
                     }
                     
                 }
                 viewModel.refresh()
                 wait(for: [expectation], timeout: 2.0)
    }
    
    func testApplicationWillEnterForeground_NoTimestamp(){
        UserDefaults.standard.removeObject(forKey: "didFetchWeatherData")
        let expectation = XCTestExpectation(description: "Fetch weather data")
        viewModel.didFetchWeatherData = { (result) in
                expectation.fulfill()
        }
        NotificationCenter.default.post(name: NSNotification.Name.NSExtensionHostWillEnterForeground, object: nil)
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testApplicationWillEnterForeground_ShouldRefresh(){
        UserDefaults.standard.set(Date().addingTimeInterval(-3600.0), forKey: "didFetchWeatherData")
        let expectation = XCTestExpectation(description: "Fetch weather data")
        viewModel.didFetchWeatherData = { (result) in
                expectation.fulfill()
        }
        NotificationCenter.default.post(name: NSNotification.Name.NSExtensionHostWillEnterForeground, object: nil)
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testApplicationWillEnterForeground_ShouldNotRefresh(){
        UserDefaults.standard.set(Date(), forKey: "didFetchWeatherData")
        let expectation = XCTestExpectation(description: "Fetch weather data")
        expectation.isInverted = true
        viewModel.didFetchWeatherData = { (result) in
                expectation.fulfill()
        }
        NotificationCenter.default.post(name: NSNotification.Name.NSExtensionHostWillEnterForeground, object: nil)
        wait(for: [expectation], timeout: 2.0)
    }
    
}
