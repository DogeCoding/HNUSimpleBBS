//
//  BBSMessageFooterView.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/24.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class BBSMessageFooterView: UICollectionReusableView {
    lazy var noDataImage: UIImageView = {
       let image = UIImageView(image: UIImage(named: "icon_message_empty"))
        addSubview(image)
        image.snp.makeConstraints({ (make) in
            make.width.equalTo(180)
            make.height.equalTo(160)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-30)
        })
        return image
    }()
    var isShowNoDataImg: Bool
    var noDataText: String
    var textColor: UIColor {
        didSet {
            tipLabel.textColor = textColor
        }
    }
    fileprivate var tipLabel: UILabel
    fileprivate var isHasData = false
    fileprivate var isHasMore = false
    
    override init(frame: CGRect) {
        isShowNoDataImg = false
        noDataText = "下拉查看更多..."
        tipLabel = UILabel(frame: frame)
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        tipLabel.textColor = UIColorFromRGB(0x999999)
        tipLabel.text = "下拉查看更多..."
        tipLabel.textAlignment = .center
        textColor = UIColorFromRGB(0x999999)
        
        super.init(frame: frame)
        
        addSubview(tipLabel)
        tipLabel.snp.makeConstraints({ (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets.zero)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTip(isHasData hasData: Bool, isHasMore hasMore: Bool) {
        isHasData = hasData
        isHasMore = hasMore
        updateTip()
    }
    
    fileprivate func updateTip() {
        if isHasData {
            if isHasMore {
                tipLabel.text = "下拉查看更多..."
            } else {
                tipLabel.text = "没有更多内容了"
            }
            noDataImage.isHidden = true
            tipLabel.snp.remakeConstraints { (make) in
                make.edges.equalTo(self).inset(UIEdgeInsets.zero)
            }
        } else {
            if isShowNoDataImg {
                tipLabel.text = noDataText
                noDataImage.isHidden = false
                tipLabel.snp.remakeConstraints { (make) in
                    make.left.right.bottom.equalTo(self)
                    make.height.equalTo(25)
                }
            } else {
                tipLabel.text = "还没有数据哦~~"
            }
        }
    }
    
    func startFetch() {
        tipLabel.isHidden = true
        startRolling()
        updateTip()
    }
    
    func endFetch() {
        tipLabel.isHidden = false
        endRolling()
        updateTip()
    }
}
