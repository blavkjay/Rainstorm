//
//  NetworkService.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 22/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation

protocol NetworkService {
    typealias FetchDataCompletion = (Data?, URLResponse?,Error?) -> Void
    
    func fetchData(with url: URL, completionHandler: @escaping FetchDataCompletion)
}
