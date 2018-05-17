//
//  BBSTabbar.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/17.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import SnapKit

class BBSTabbar: UIView {
    var backgroundView = UIView()
    
    var homeBtn = UIButton()
    
    var messageBtn = UIButton()
    
    var scheduleBtn = UIButton()
    
    var mineBtn = UIButton()
    
    fileprivate var badgeView = UIView()
    
    init() {
        let frame = CGRect.init(x: 0, y: 0, width: BBSScreenWidth, height: BBSTabbarHeight)
        super.init(frame: frame)

        backgroundView.backgroundColor = UIColorFromRGB(0xffffff)
        backgroundView.frame = frame
        addSubview(backgroundView)
        
        homeBtn.setImage(UIImage.init(named: ""), for: .normal)
        homeBtn.setImage(UIImage.init(named: ""), for: .selected)
        
        messageBtn.setImage(UIImage.init(named: ""), for: .normal)
        messageBtn.setImage(UIImage.init(named: ""), for: .selected)
        
        scheduleBtn.setImage(UIImage.init(named: ""), for: .normal)
        scheduleBtn.setImage(UIImage.init(named: ""), for: .selected)
        
        mineBtn.setImage(UIImage.init(named: ""), for: .normal)
        mineBtn.setImage(UIImage.init(named: ""), for: .selected)
        
        homeBtn.isSelected = true
        homeBtn.backgroundColor = .clear
        messageBtn.backgroundColor = .clear
        scheduleBtn.backgroundColor = .clear
        mineBtn.backgroundColor = .clear
        
        badgeView.backgroundColor = UIColorFromRGB(0xff4f4f)
        badgeView.layer.cornerRadius = 4
        badgeView.clipsToBounds = true
        badgeView.isUserInteractionEnabled = false
        badgeView.isHidden = true
        messageBtn.addSubview(badgeView)
        
        // badgeView 8*8
        badgeView.snp.makeConstraints { (make) in
            make.left.equalTo(messageBtn.width() / 2 + 8)
            make.top.equalTo(6)
            make.width.height.equalTo(8)
        }
        sendSubview(toBack: backgroundView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func plaveAt(viewController vc: UIViewController) -> BBSTabbar {
        vc.view.addSubview(self)
        snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(vc.view)
            make.height.equalTo(49)
        }
        return self
    }
    
    func showRedDot(isShow: Bool) -> Void {
        if isShow {
            badgeView.isHidden = false
        } else {
            badgeView.isHidden = true
        }
    }
    
}
