//
//  WeekViewModelTests.swift
//  RainstormTests
//
//  Created by OLAJUWON BALOGUN on 22/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import XCTest
@testable import Rainstorm

class WeekViewModelTests: XCTestCase {

    var viewModel: WeekViewModel!
    
    override func setUpWithError() throws {
       let data = loadStub(name: "darksky", extension: "json")
       let decoder = JSONDecoder()
       decoder.dateDecodingStrategy = .secondsSince1970
       let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        viewModel = WeekViewModel(weatherData: darkSkyResponse.forecast)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNumberOfDays(){
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }

    func testViewModelForIndex(){
        let weekDayViewModel = viewModel.viewModel(for: 5)
        XCTAssertEqual(weekDayViewModel.day, "Sunday")
        XCTAssertEqual(weekDayViewModel.date, "September 2")
    }


}
