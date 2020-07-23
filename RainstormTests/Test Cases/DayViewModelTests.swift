//
//  DayViewModelTests.swift
//  RainstormTests
//
//  Created by OLAJUWON BALOGUN on 22/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import XCTest
@testable import Rainstorm

class DayViewModelTests: XCTestCase {

    var viewModel: DayViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        let data = loadStub(name: "darksky", extension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        viewModel = DayViewModel(weatherData: darkSkyResponse.current)
    }

    override func tearDownWithError() throws {
        
    }

    func testDate(){
        XCTAssertEqual(viewModel.date, "Tue, August 28 2018")
    }
    
    func testTime(){
        XCTAssertEqual(viewModel.time, "14:08 PM")
    }
    
    func testSummary(){
        XCTAssertEqual(viewModel.summary, "Overcast")
    }
    
    func testTemperature(){
        XCTAssertEqual(viewModel.temperature, "57.7 F")
    }
    
    func testWindSpeed(){
        XCTAssertEqual(viewModel.windSpeed, "5 MPH")
    }
    
    func testImage(){
        let viewModelImage = viewModel.image
        let imageDataViewModel = viewModelImage!.pngData()!
        let imageDataReference = UIImage(named: "clear-night")!.pngData()!
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage?.size.width, 45.0)
        XCTAssertEqual(viewModelImage?.size.height, 33.0)
        
    }
   

}
