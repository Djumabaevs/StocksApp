//
//  ApiCaller.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 25/10/21.
//

import Foundation

final class ApiCaller {
    static let shared = ApiCaller()
    
    private init() {}
    
    //MARK: - Public
    
    //get stock info
    
    //search stocks
    
    //MARK: - Private
    
    private enum Endpoint: String {
        case search
    }
}
