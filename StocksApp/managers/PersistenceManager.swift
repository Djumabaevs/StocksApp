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
        
    }
    
    static let shared = PersistenceManager()
    
    private init() {}
    
    //MARK: - Public
    
    public var watchlist: [String] {
        return []
    }
    
    public func addToWatchlist() {
            
    }
    
    public func removeFromWatchlist() {
        
    }
    
    //MARK: - Private
    
    private var hasOnboarded: Bool {
        return false
    }
}
