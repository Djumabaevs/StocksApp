//
//  NewsStory.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 30/10/21.
//

import Foundation

struct NewStory: Codable {
      let category: String
      let datetime: TimeInterval
      let headline: String
      let image: String
      let related: String
      let source: String
      let summary: String
      let url: String
}
