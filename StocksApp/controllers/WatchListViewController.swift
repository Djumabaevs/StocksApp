//
//  ViewController.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 24/10/21.
//

import FloatingPanel
import UIKit

class WatchListViewController: UIViewController {
    
    private var searchTimer: Timer?
    
    private var panel: FloatingPanelController?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = .tertiarySystemBackground
        setupSearchController()
        setupFloatingPanel()
        setupTitleView()
        
//        setupChild()
    }
    
    private func setupFloatingPanel() {
        let vc = TopStoriesNewsViewController(type: .topStories)
        let panel = FloatingPanelController()
        panel.surfaceView.backgroundColor = .secondarySystemBackground
        panel.set(contentViewController: vc)
        panel.addPanel(toParent: self)
        panel.delegate = self
        panel.track(scrollView: vc.tableView)
    }
    
    //MARK: - Private
    
//    private func setupChild() {
//        let vc = PanelViewController()
//        addChild(vc)
//
//        view.addSubview(vc.view)
//        vc.view.frame = CGRect(x: 0, y: view.height/2, width: view.width, height: view.height)
//        vc.didMove(toParent: self)
//    }
    
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
        
        //Reset timer
        
        searchTimer?.invalidate()
        
        //Kick of new timer
        //Optimize to reduce number of searches for when user stops typing
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            //Call API to search
            ApiCaller.shared.search(query: query) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        resultsVC.update(with: response.result)
                    }
                case .failure(let error):
                    resultsVC.update(with: [])
                    print(error)
                }
            }
            
        })
        //Update results controller
        
//        print(query)
    }
}

extension WatchListViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidSelect(searchResult: SearchResult) {
        //Present pet details for given selection
        // print("Did select: \(searchResult.displaySymbol)")
        navigationItem.searchController?.searchBar.resignFirstResponder()
        
        let vc = StockDetailsViewController()
        let navVC = UINavigationController(rootViewController: vc)
        vc.title = searchResult.description
        present(navVC, animated: true)
    }
}

extension WatchListViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        navigationItem.titleView?.isHidden = fpc.state == .full
    }
}

