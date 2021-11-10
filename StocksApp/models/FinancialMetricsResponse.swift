//
//  FinancialMetricsResponse.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 10/11/21.
//

import Foundation

struct FinancialMetricsResponse: Codable {
    let metric: Metrics
}

struct Metrics: Codable {
    {
        let 10DayAverageTradingVolume: Float
        let 52WeekHigh: Double
        let 52WeekLow: Double
        let 52WeekLowDate: String
        let 52WeekPriceReturnDaily: Float
        let beta: Float
    }
}
