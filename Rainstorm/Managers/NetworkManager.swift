//
//  NetworkManager.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 22/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import Foundation


class NetworkManager: NetworkService{
    
    func fetchData(with url: URL, completionHandler: @escaping NetworkService.FetchDataCompletion) {
        URLSession.shared.dataTask(with: url,completionHandler: completionHandler).resume()
    }
    
}
