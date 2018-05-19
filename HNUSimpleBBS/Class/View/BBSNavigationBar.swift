//
//  CDNavigationBar.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/14.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate class PPQNavigationBarCustomButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let view = self.superview {
            if let view = view as? UIStackView, let superView = view.superview {
                superView.addConstraint(NSLayoutConstraint(item: view,
                                                           attribute: .leading,
                                                           relatedBy: .equal,
                                                           toItem: superView,
                                                           attribute: .leading,
                                                           multiplier: 1,
                                                           constant: 0))
            }
        }
    }

}



class BBSNavigationBar: UINavigationBar {
    var backBtn = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        $0.addTarget(self, action: #selector(handleNaviBack), for: .touchUpInside)
        $0.backgroundColor = UIColor.bbs_randomColor()
        $0.setImage(UIImage.init(named: "icon_nav_back"), for: .normal)
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
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        return self
    }
    
    func setBottomLineStyle() -> BBSNavigationBar {
        isTranslucent = false
        barTintColor = AppTintColor
        
        titleTextAttributes = [.foregroundColor : AppTitleColor]
        let ly = CALayer()
        ly.frame = CGRect(x: 0, y: 43, width: BBSScreenWidth, height: 1)
        ly.backgroundColor = UIColor.black.cgColor
        ly.opacity = 0.05
        layer.addSublayer(ly)
        
        return self
    }
    
    func setNavAndStatusBar(color: UIColor) {
        if let wrapView = superview {
            wrapView.backgroundColor = color
        }
    }
    
    func place(at vc: ASViewController<ASDisplayNode>) -> BBSNavigationBar {
        let wrap = UIView()
        wrap.addSubview(self)
        wrap.backgroundColor = .clear
        
        snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(wrap)
            make.height.equalTo(44)
        }
        
        vc.view.addSubview(wrap)
        wrap.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(vc.view)
            
            if vc.isPrefersStatusBarHidden() {
                if IsIphone_X {
                    make.height.equalTo(98)
                } else {
                    make.height.equalTo(54)
                }
            } else {
                if IsIphone_X {
                    make.height.equalTo(88)
                } else {
                    make.height.equalTo(64)
                }
            }
        }
        return self
    }
    
    @objc func handleNaviBack() -> Void {
        RootViewController.navigationController?.popViewController(animated: true)
    }
    
    func replace(backTarget target: Any, selector: Selector) {
        let allTargets = backBtn.allTargets
        for tg in allTargets {
            backBtn.removeTarget(tg, action: nil, for: .touchUpInside)
        }
        
        backBtn.addTarget(target, action: selector, for: .touchUpInside)
    }
    
}
