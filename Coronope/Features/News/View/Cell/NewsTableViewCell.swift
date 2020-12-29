//
//  NewsTableViewCell.swift
//  Coronope
//
//  Created by IT Division on 29/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.cornerRadius = 10
        self.containerView.backgroundColor = .systemYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setData(_ news: NewsModel){
        self.newsTitle.text = news.title
        self.newsImageView.downloadImage(from: URL(string: news.urlToImage)!)
    }
}
