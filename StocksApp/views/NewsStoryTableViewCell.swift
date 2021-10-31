//
//  NewsStoryTableViewCell.swift
//  StocksApp
//
//  Created by Bakyt Dzhumabaev on 31/10/21.
//

import UIKit

class NewsStoryTableViewCell: UITableViewCell {
    static let identifier = "NewsStoryTableViewCell"
    
    static let preferredHeight:CGFloat = 140
    
    struct ViewModel {
        let source: String
        let headline: String
        let dateString: String
        let imageURL: URL?
        
        init(model: NewStory) {
            self.source = model.source
            self.headline = model.headline
            self.dateString = "Jun 21, 2021"
            self.imageURL = nil
        }
    }
        
    //Source
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    //Headline
    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    //Date
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    //Image
    private let storyImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.layer.masksToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
        backgroundColor = .systemBlue
        addSubviews(sourceLabel, headlineLabel, dateLabel, storyImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = contentView.height - 6
        storyImageView.frame = CGRect(x: contentView.width - imageSize - 10,
                                      y: 3,
                                      width: imageSize,
                                      height: imageSize)
        //Layout labels
        let availableWidth: CGFloat = contentView.width - separatorInset.left - imageSize - 10 - 5
        dateLabel.frame = CGRect(x: separatorInset.left,
                                 y: contentView.height - 40,
                                 width: availableWidth,
                                 height: 40)
        sourceLabel.sizeToFit()
        sourceLabel.frame = CGRect(x: separatorInset.left,
                                 y: 4,
                                 width: availableWidth,
                                 height: sourceLabel.height)
        headlineLabel.frame = CGRect(x: separatorInset.left,
                                     y: sourceLabel.bottom + 5,
                                 width: availableWidth,
                                 height: contentView.height - sourceLabel.bottom - dateLabel.height - 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sourceLabel.text = nil
        headlineLabel.text = nil
        dateLabel.text = nil
        storyImageView.image = nil
    }
    
    public func configure(with viewModel: ViewModel) {
        headlineLabel.text = viewModel.headline
        sourceLabel.text = viewModel.source
        dateLabel.text = viewModel.dateString
    }

}
