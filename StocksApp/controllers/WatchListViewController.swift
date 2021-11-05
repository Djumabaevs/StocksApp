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
    
    static var maxChangeWidth: CGFloat = 0
    
    
    //Model
    private var watchlistMap: [String: [CandleStick]] = [:]
    
    //ViewModel
    private var viewModels: [WatchListTableViewCell.ViewModel] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(
            WatchListTableViewCell.self,
            forCellReuseIdentifier: WatchListTableViewCell.identifier)
        return table
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = .tertiarySystemBackground
        setupSearchController()
        setupTableView()
        fetchWatchlistData()
        setupFloatingPanel()
        setupTitleView()
        
//        setupChild()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
    
    private func fetchWatchlistData() {
        let symbols = PersistenceManager.shared.watchlist
        
        let group = DispatchGroup()
        
        for symbol in symbols {
            group.enter()
            //Fetch market data per symbol
            //watchlistMap[symbol] = ["some string"]
            ApiCaller.shared.marketData(for: symbol) { [weak self] result in
                defer {
                    group.leave()
                }
                
                switch result{
                case .success(let data):
                    let candleSticks = data.candleSticks
                    self?.watchlistMap[symbol] = candleSticks
                case .failure(let error):
                    print(error)
                }
            }
        }
     //   tableView.reloadData()
        group.notify(queue: .main) { [weak self] in
            self?.createViewModels()
            self?.tableView.reloadData()
        }
    }
    
    private func createViewModels() {
        var viewmodels = [WatchListTableViewCell.ViewModel]()
        
        for(symbol, candleSticks) in watchlistMap {
            let changePercentage = getChangePercentage(symbol: symbol, data: candleSticks)
            viewmodels.append(
                .init(
                    symbol: symbol,
                    companyName: UserDefaults.standard.string(forKey: symbol) ?? "Company",
                    price: getLatestClosingPrice(from: candleSticks),
                    changeColor: changePercentage < 0 ? .systemRed : .systemGreen,
                    changePercentage: String.percentage(from: changePercentage),
                    chartViewModel: .init(
                        data: candleSticks.reversed().map { $0.close },
                        showLegend: false,
                        showAxis: false)
                )
            )
        }
        print("\n\n\(viewmodels)\n\n")
        
        self.viewModels = viewmodels
    }
    
    private func getChangePercentage(symbol: String, data: [CandleStick]) -> Double {
  //      let today = Date()
  //      let priorDate = Date().addingTimeInterval(-((3600*24)*2))
        let latestDate = data[0].date
        guard let latestClose = data.first?.close,
            let priorClose = data.first(where: {
                !Calendar.current.isDate($0.date, inSameDayAs: latestDate)
            })?.close else {
            return 0
        }
    //    print("Symbol: \(symbol): Current \(latestDate): \(latestClose) |  Prior \(priorClose)")
        let diff = 1 - (priorClose/latestClose)
    //    print("\(symbol): \(diff)%")
        
        return diff
    }
    
    private func getLatestClosingPrice(from data: [CandleStick]) -> String {
        guard let closingPrice = data.first?.close else {
            return ""
        }
        return String.formatted(number: closingPrice)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
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

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchListTableViewCell.identifier, for: indexPath) as? WatchListTableViewCell else {
            fatalError()
        }
        cell.delegate = self
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WatchListTableViewCell.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Open details for selection
        
    }
}

extension WatchListViewController: WatchListTableViewCellDelegate {
    func didUpdateMaxWidth() {
        //Optimize: only refresh rows prior to the current row that changes the max width
        tableView.reloadData()
    }
}

