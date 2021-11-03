//
//  StockChartView.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 1/11/21.
//

import UIKit

class StockChartView: UIView {
    
    struct ViewModel {
        let data: [CandleStick]
        let showLegend: Bool
        let showAxis: Bool
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func reset() {
        
    }
}
