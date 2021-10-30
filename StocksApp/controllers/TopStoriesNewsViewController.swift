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
   
    enum `Type` {
        case topStories
        case company(symbol: String)
        
        var title: String {
            switch self {
            case .topStories:
                return "Top Stories"
            case .company(let symbol):
                return symbol.uppercased()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        fetchNews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupTable() {
        
    }
    
    private func fetchNews() {
        
    }
    
    private func open(url: URL) {
        
    }
 

}
