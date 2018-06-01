//
//  FeedImageDetailViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/6/1.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class FeedImageDetailViewController: UIViewController {
    
    var imageDetail: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let bar = BBSNavigationBar().setBottomLineStyle().place(at: self)
        bar.backgroundColor = .white
        bar.barItem.titleView = {
            let label = UILabel()
            label.text = "照片浏览"
            label.textColor = UIColorFromRGB(0x222222)
            label.font = UIFont.bbs_defaultFontWith(size: 18)
            label.sizeToFit()
            return label
        }()
        
        view.addSubview(imageDetail)
        imageDetail.snp.makeConstraints { (make) in
            make.top.equalTo(bar.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    
}
