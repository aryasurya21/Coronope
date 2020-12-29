//
//  StatsCollectionViewCell.swift
//  Coronope
//
//  Created by IT Division on 28/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit

class StatsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 30
    }
}
