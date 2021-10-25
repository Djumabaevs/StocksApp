//
//  ViewController.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 24/10/21.
//

import UIKit

class WatchListViewController: UIViewController {
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = .tertiarySystemBackground
        setupSearchController()
        setupTitleView()
    }
    
    //MARK: - Private
    
    private func setupTitleView() {
        let titleView = UIView(frame: CGRect(
                                x: 0,
                                y: 0,
                                width: view.width,
                                height: navigationController?.navigationBar.height ?? 100))
        titleView.backgroundColor = .link
        navigationItem.titleView = titleView
        
    }

    private func setupSearchController() {
        let resultVC = SearchResultsViewController()
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
}

extension WatchListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let resultsVC = searchController.searchResultsController as? SearchResultsViewController,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        //Optimize to reduce number of searches for when user stops typing
        
        //Call API to search
        
        
        //Update results controller
        
//        print(query)
    }
}

