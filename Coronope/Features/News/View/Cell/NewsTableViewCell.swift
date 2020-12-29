//
//  NewsTableViewCell.swift
//  Coronope
//
//  Created by IT Division on 29/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 10
        self.shadowView.layer.cornerRadius = 10
        self.containerView.backgroundColor = .systemYellow
        self.shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        self.shadowView.layer.shadowRadius = 8
        self.shadowView.layer.shadowOpacity = 0.5
        self.shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
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
