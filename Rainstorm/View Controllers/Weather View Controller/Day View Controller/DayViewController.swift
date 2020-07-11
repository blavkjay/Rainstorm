//
//  DayViewController.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 11/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import UIKit

final class DayViewController: UIViewController {

    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    //MARK: - Helper method
    private func setUpView(){
        //configure view
        view.backgroundColor = .green
    }
}
