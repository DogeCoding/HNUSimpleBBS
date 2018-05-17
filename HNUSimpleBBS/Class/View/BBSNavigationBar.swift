//
//  CDNavigationBar.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/14.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class BBSNavigationBar: UINavigationBar {
    var backBtn = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        $0.addTarget(self, action: #selector(handleNaviBack), for: .touchUpInside)
        $0.backgroundColor = UIColor.bbs_randomColor()
        $0.setImage(UIImage.init(named: ""), for: .normal)
    }
    
    var barItem: UINavigationItem = UINavigationItem()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backItem = UIBarButtonItem.init(customView: backBtn)
        
        var fixedSpace: CGFloat = 0
        if BBSScreenWidth > 370 {
            fixedSpace = -20
        } else {
            fixedSpace = -16
        }
        if BBSCurrentSystemVersion >= 11.0 {
            backBtn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: fixedSpace, bottom: 0, right: 0)
            barItem.leftBarButtonItem = backItem
        } else {
            let space = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            space.width = fixedSpace
            barItem.leftBarButtonItems = [space, backItem]
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTransparentStyle() -> BBSNavigationBar {
        return self
    }
    
    func place(at vc: ASViewController<ASDisplayNode>) -> Void {
        
    }
    
    @objc func handleNaviBack() -> Void {
        
    }
    
}
