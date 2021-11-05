//
//  PersistenceManager.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 25/10/21.
//

import Foundation

final class PersistenceManager {
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        static let onboardedKey = "hasOnboarded"
        static let watchListKey = "watchlist"
    }
    
    static let shared = PersistenceManager()
    
    private init() {}
    
    //MARK: - Public
    
    public var watchlist: [String] {
        if !hasOnboarded {
            userDefaults.setValue(true, forKey: Constants.onboardedKey)
            setupDefaults()
        }
        return userDefaults.stringArray(forKey: Constants.watchListKey) ?? []
    }
    
    public func addToWatchlist() {
            
    }
    
    public func removeFromWatchlist(symbol: String) {
        var newList = [String]()
        userDefaults.set(nil, forKey: symbol)
        for item in watchlist where item != symbol {
            newList.append(item)
        }
        
        userDefaults.set(newList, forKey: Constants.watchListKey)
    }
    
    //MARK: - Private
    
    private var hasOnboarded: Bool {
        return userDefaults.bool(forKey: Constants.onboardedKey)
    }
    
    private func setupDefaults() {
        let map: [String: String] = [
            "AAPL": "Apple Inc",
            "MSFT": "Microsoft Corporation",
            "SNAP": "Snap Inc",
            "GOOG": "Alphabet",
            "AMZN": "Amazon.com, Inc",
            "WORK": "Slack technologies",
            "FB": "Facebook Inc",
            "NVDA": "Nvidia Inc",
            "NKE": "Nike",
            "PINS": "Pinterest Inc"
        ]
        let symbols = map.keys.map { $0 }
        userDefaults.setValue(symbols, forKey: Constants.watchListKey)
        
        for (symbol, name) in map {
            userDefaults.setValue(name, forKey: symbol)
        }
    }
}
