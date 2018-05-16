//
//  CDNavigationBar.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/14.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class BBSNavigationBar: UINavigationBar {
    var backBtn = ASButtonNode().then {
        $0.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        $0.addTarget(self, action: #selector(handleNaviBack), forControlEvents: .touchUpInside)
        $0.backgroundColor = UIColor.bbs_randomColor()
        $0.setImage(UIImage.init(named: ""), for: .normal)
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var fixedSpace: CGFloat = 0
        if BBSScreenWidth > 370 {
            fixedSpace = -20
        } else {
            fixedSpace = -16
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
