//
//  WeekViewController.swift
//  Rainstorm
//
//  Created by OLAJUWON BALOGUN on 11/07/2020.
//  Copyright © 2020 OLAJUWON BALOGUN. All rights reserved.
//

import UIKit



protocol WeekViewControllerDelegate: class {
    func controllerDidRefresh(_ controller: WeekViewController)
}


class WeekViewController: UIViewController {
    
    
    weak var delegate : WeekViewControllerDelegate?

    var viewModel: WeekViewModel?{
        didSet{
            refreshControl.endRefreshing()
            guard let viewModel = viewModel else{
                return
            }
            setUpViewModel(with: viewModel)
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.RainStorm.baseTintColor
        return refreshControl
    }()
    
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.isHidden = true
            tableView.dataSource = self
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableView.automaticDimension
            tableView.showsVerticalScrollIndicator = false
            tableView.refreshControl = refreshControl
        }
    }
    
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!{
        didSet{
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup view
        setUpView()
    }
    
    //MARK: - Helper method
    private func setUpView(){
        //configure view
        view.backgroundColor = .white
    }

    private func setUpViewModel(with viewModel: WeekViewModel){
        activityIndicatorView.stopAnimating()
        tableView.reloadData()
        tableView.isHidden = false
    }
    
   @objc private func refresh(_ sender: UIRefreshControl){
            delegate?.controllerDidRefresh(self)
    }
}


extension WeekViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDays ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekDayTableViewCell.reuseIdentifier, for: indexPath) as? WeekDayTableViewCell else {fatalError("unable to deque week day table view cell")}
        guard let viewModel = viewModel else{
            fatalError("No view model present")
        }
        cell.configure(with: viewModel.viewModel(for: indexPath.row))
        return cell
    }
}
