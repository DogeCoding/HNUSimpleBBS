//
//  MilitaryNewsCell.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/1.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit
import Kingfisher

final class MilitaryNewsOnePicCell: UICollectionViewCell {
    
    static let nibName = "MilitaryNewsOnePicCell"
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var rightThumbView: UIImageView!
    
    // judge:
    /// has_video middle_image
    // data: middle_image.url
    var data: MilitaryNewsOnePicCellViewModel? {
        didSet {
            newsTitleLabel.attributedText = NSAttributedString(string: data!.title)
            
            rightThumbView.kf.setImage(with: URL(string: data!.rightThumbImageUrl))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        newsTitleLabel.sizeToFit()
    }
}
