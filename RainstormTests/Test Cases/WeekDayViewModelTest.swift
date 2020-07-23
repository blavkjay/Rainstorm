//
//  WeekDayViewModelTest.swift
//  RainstormTests
//
//  Created by OLAJUWON BALOGUN on 22/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import XCTest
@testable import Rainstorm

class WeekDayViewModelTest: XCTestCase {

    var viewModel: WeekDayViewModel!
    
    override func setUpWithError() throws {
       super.setUp()
        let data = loadStub(name: "darksky", extension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        viewModel =  WeekDayViewModel(weatherData: darkSkyResponse.forecast[5])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDate(){
        XCTAssertEqual(viewModel.date, "September 2")
    }
    
    func testDay(){
        XCTAssertEqual(viewModel.day, "Sunday")
    }
    
    
    func testImage(){
        let viewModelImage = viewModel.image
        let imageDataViewModel = viewModelImage!.pngData()!
        let imageDataReference = UIImage(named: "clear-night")!.pngData()!
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage?.size.width, 45.0)
        XCTAssertEqual(viewModelImage?.size.height, 33.0)
        
    }
    
    func testTemperature(){
        XCTAssertEqual(viewModel.temperature, "53.9 - 68.2")
    }
    
    func testWindSpeed(){
        XCTAssertEqual(viewModel.windSpeed, "5 MPH")
    }
    

}
