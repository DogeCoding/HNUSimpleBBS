//
//  CDNavigationBar.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/14.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class BBSNavigationBar: UINavigationBar {
    var backBtn: ASButtonNode = {
        let btn = ASButtonNode.init()
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.addTarget(self, action: #selector(handleNaviBack), forControlEvents: .touchUpInside)
        btn.backgroundColor = 
        return btn
    }()
    var barItem: UINavigationItem? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
