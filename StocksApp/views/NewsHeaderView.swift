//
//  NewsHeaderView.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 30/10/21.
//

import UIKit

class NewsHeaderView: UITableViewHeaderFooterView {
    static let identifier = "NewsHeaderView"
    static let preferredHeight: CGFloat = 70
    
    struct ViewModel {
        let title: String
        let shouldShowAddButton
    }

}
