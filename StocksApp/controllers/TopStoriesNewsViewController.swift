//
//  TopStoriesNewsViewController.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 25/10/21.
//

import UIKit

class TopStoriesNewsViewController: UIViewController {

    let tableView: UITableView = {
        let table = UITableView()
        //Register cell, header
        
        
        return table
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        fetchNews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

 

}
