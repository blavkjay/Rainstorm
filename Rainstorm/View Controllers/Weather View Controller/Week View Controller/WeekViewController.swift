//
//  WeekViewController.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 11/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import UIKit

class WeekViewController: UIViewController {

    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup view
        setUpView()
    }
    
    //MARK: - Helper method
    private func setUpView(){
        //configure view
        view.backgroundColor = .red
    }

}
