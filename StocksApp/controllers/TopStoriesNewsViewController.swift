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
    
    private let type: Type
   
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
    
    init(type: Type) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
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
