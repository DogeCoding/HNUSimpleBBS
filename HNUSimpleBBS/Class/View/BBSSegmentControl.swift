//
//  BBSSegmentControl.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/19.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let kBBSSegmentControlTitleTagBase = 100
fileprivate let kBBSSegmentControlHeight: CGFloat = 30

class BBSSegmentControl: UIControl {
    
    var selectedIndex: NSInteger {
        willSet {
            if selectedIndex == newValue {
                return
            }
            if let last = viewWithTag(kBBSSegmentControlTitleTagBase + selectedIndex) as? UILabel {
                last.font = UIFont.bbs_fontWith(name: "PingFangSC-Regular", size: 14)
                last.alpha = 0.6
            }
            if let cur = viewWithTag(kBBSSegmentControlTitleTagBase + newValue) as? UILabel {
                cur.font = UIFont.bbs_defaultFontWith(size: 18)
                cur.alpha = 1
            }
        }
    }
    
    fileprivate var titleCount: NSInteger
    
    fileprivate var titles: Array<String> = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var offsetX = (width()-totleWidth)/2
        for i in 0..<subviews.count {
            if let v = viewWithTag(kBBSSegmentControlTitleTagBase + i) {
                v.setLeft(offsetX)
                offsetX = v.right()
            }
        }
    }
    
    fileprivate var totleWidth: CGFloat
    
    override init(frame: CGRect) {
        selectedIndex = 0
        titleCount = 0
        totleWidth = 0
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(titles: Array<String>) {
        selectedIndex = -1
        titleCount = titles.count
        totleWidth = 0
        super.init(frame: CGRect(x: 0, y: 0, width: BBSScreenWidth, height: kBBSSegmentControlHeight))
        backgroundColor = .clear
        set(titles: titles)
        
        setNeedsLayout()
    }
    
    fileprivate func set(titles: Array<String>) {
        removeAllSubviews()
        totleWidth = 0
        titleCount = titles.count
        var index: NSInteger = 0
        for title in titles {
            let label = UILabel(frame: .zero)
            label.tag = kBBSSegmentControlTitleTagBase + index
            let font = UIFont.bbs_fontWith(name: "PingFangSC-Regular", size: 14)
            let color = UIColorFromRGB(0x222222)
            let attrStr = NSAttributedString(string: title, attributes: [.font : font, .foregroundColor : color])
            let size = attrStr.boundingRect(with: CGSize(width: 100, height: kBBSSegmentControlHeight), options: .usesLineFragmentOrigin, context: nil).size
            label.frame = CGRect(x: 0, y: 0, width: size.width + 11*2, height: kBBSSegmentControlHeight)
            label.attributedText = attrStr
            label.textAlignment = .center
            label.backgroundColor = .clear
            label.alpha = 0.6
            addSubview(label)
            totleWidth += label.width()
            index += 1
        }
        if selectedIndex == -1 {
            selectedIndex = 0
        }
        self.titles = titles
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
            return
        }
        for index in 0..<subviews.count {
            if let v = viewWithTag(kBBSSegmentControlTitleTagBase + index), v.frame.contains(location) {
                selectedIndex = index
                sendActions(for: .valueChanged)
            }
        }
    }
}
