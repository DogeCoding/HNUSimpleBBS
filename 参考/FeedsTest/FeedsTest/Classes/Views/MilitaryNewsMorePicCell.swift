//
//  MilitaryNewsMorePicCell.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/1.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit

final class MilitaryNewsMorePicCell: UICollectionViewCell {
    
    fileprivate static let font = UIFont.systemFont(ofSize: 16)
    static let nibName = "MilitaryNewsMorePicCell"
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var leftThumbView: UIImageView!
    @IBOutlet weak var middleThumbView: UIImageView!
    @IBOutlet weak var rightThumbView: UIImageView!
    
    
    /// judge: has_image image_list.count >= 1
    // data: image_list.url
    var data: MilitaryNewsMorePicCellViewModel? {
        didSet {
            newsTitleLabel.attributedText = NSAttributedString(string: data!.title)
//            newsTitleLabel.text = data!.title

            leftThumbView.kf.setImage(with: URL(string: data!.leftThumbImageUrl))
            middleThumbView.kf.setImage(with: URL(string: data!.middleThumbImageUrl))
            rightThumbView.kf.setImage(with: URL(string: data!.rightThumbImageUrl))
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsTitleLabel.font = MilitaryNewsMorePicCell.font
    }
    
    static func textHeight(_ text: String, width: CGFloat) -> CGFloat {
        let insets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        let constrainedSize = CGSize(width: width - insets.left - insets.right, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [ NSAttributedStringKey.font: font ]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height) + insets.top + insets.bottom
    }
}
