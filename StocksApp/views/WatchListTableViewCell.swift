//
//  WatchListTableViewCell.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 1/11/21.
//

import UIKit

class WatchListTableViewCell: UITableViewCell {
    static let identifier = "WatchListTableViewCell"
    
    static let preferredHeight: CGFloat = 60
    
    struct ViewModel {
        let symbol: String
        let companyName: String
        let price: String //formatted
        let changeColor: UIColor //red or green
        let changePercentage: String //formatted
        //let chartViewModel: StockChartView.ViewModel
    }
    
    //Symbol label
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    //Company label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    //Price label
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    //Change in price label
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    //Mini cahrt view
    private let miniChartView = StockChartView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(
            priceLabel,
            changeLabel,
            miniChartView,
            nameLabel,
            symbolLabel
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        priceLabel.text = nil
        symbolLabel.text = nil
        changeLabel.text = nil
        miniChartView.reset()
    }
    
    public func configure(with viewModel: ViewModel) {
        symbolLabel.text = viewModel.symbol
        nameLabel.text = viewModel.companyName
        priceLabel.text = viewModel.price
        changeLabel.text = viewModel.changePercentage
        changeLabel.backgroundColor = viewModel.changeColor
        //Configure chart
    }

}
