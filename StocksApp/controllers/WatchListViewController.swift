//
//  ViewController.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 24/10/21.
//

import UIKit

class WatchListViewController: UIViewController {
    
    private var searchTimer: Timer?
    
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
   //     titleView.backgroundColor = .link
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: titleView.width - 20, height: titleView.height))
        label.text = "GoChip"
        label.font = .systemFont(ofSize: 38, weight: .medium)
        titleView.addSubview(label)
        navigationItem.titleView = titleView
        
    }

    private func setupSearchController() {
        let resultVC = SearchResultsViewController()
        resultVC.delegate = self
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
        
   
        //Update results controller
        
//        print(query)
    }
}

extension WatchListViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidSelect(searchResult: SearchResult) {
        //Present pet details for given selection
        print("Did select: \(searchResult.displaySymbol)")
    }
}

