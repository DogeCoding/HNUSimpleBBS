//
//  JokeOrPctCell.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/2.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit

final class JokeOrPctCell: UICollectionViewCell {
    
    static let nibName = "JokeOrPctCell"
    
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var data: JokeOrPctCellViewModel? {
        didSet {
            if let isJoke = data?.isJoke {
                if isJoke {
                    imageView.isHidden = true
                } else {
                    jokeLabel.isHidden = true
                }
            }
            if let content = data?.content {
                jokeLabel.attributedText = NSAttributedString(string: content)
            }
            if let imageUrl = data?.large_image_url {
                imageView.kf.setImage(with: URL(string: imageUrl))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
