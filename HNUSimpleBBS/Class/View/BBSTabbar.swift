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
    
    var addBtn = UIButton()
    
    var scheduleBtn = UIButton()
    
    var mineBtn = UIButton()
    
    fileprivate var badgeView = UIView()
    
    init() {
        let frame = CGRect.init(x: 0, y: 0, width: BBSScreenWidth, height: BBSTabbarHeight)
        super.init(frame: frame)

        backgroundView.backgroundColor = UIColorFromRGB(0xffffff)
        backgroundView.frame = frame
        addSubview(backgroundView)
        
        homeBtn.setImage(UIImage.init(named: "icon_home_normal"), for: .normal)
        homeBtn.setImage(UIImage.init(named: "icon_home_selected"), for: .selected)
        homeBtn.contentMode = .scaleToFill
        addSubview(homeBtn)
        
        messageBtn.setImage(UIImage.init(named: "icon_message_normal"), for: .normal)
        messageBtn.setImage(UIImage.init(named: "icon_message_selected"), for: .selected)
        messageBtn.contentMode = .scaleToFill
        addSubview(messageBtn)
        
        addBtn.setImage(UIImage(named: "icon_add"), for: .normal)
        addBtn.contentMode = .scaleToFill
        addSubview(addBtn)
        
        scheduleBtn.setImage(UIImage.init(named: "icon_schedule_normal"), for: .normal)
        scheduleBtn.setImage(UIImage.init(named: "icon_schedule_selected"), for: .selected)
        scheduleBtn.contentMode = .scaleToFill
        addSubview(scheduleBtn)
        
        mineBtn.setImage(UIImage.init(named: "icon_mine_normal"), for: .normal)
        mineBtn.setImage(UIImage.init(named: "icon_mine_selected"), for: .selected)
        mineBtn.contentMode = .scaleToFill
        addSubview(mineBtn)
        
        addBtn.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.center.equalTo(self)
        }
        messageBtn.snp.makeConstraints { (make) in
            make.width.equalTo(49)
            make.top.bottom.equalTo(self)
            make.right.equalTo(addBtn.snp.left).offset(-15.5)
        }
        homeBtn.snp.makeConstraints { (make) in
            make.width.equalTo(49)
            make.top.bottom.equalTo(self)
            make.right.equalTo(messageBtn.snp.left).offset(-15.5)
        }
        scheduleBtn.snp.makeConstraints { (make) in
            make.width.equalTo(49)
            make.top.bottom.equalTo(self)
            make.left.equalTo(addBtn.snp.right).offset(15.5)
        }
        mineBtn.snp.makeConstraints { (make) in
            make.width.equalTo(49)
            make.top.bottom.equalTo(self)
            make.left.equalTo(scheduleBtn.snp.right).offset(15.5)
        }
        
        
        
        homeBtn.isSelected = true
        homeBtn.backgroundColor = .clear
        messageBtn.backgroundColor = .clear
        addBtn.backgroundColor = .clear
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
            make.left.equalTo(messageBtn.width / 2 + 8)
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
