//
//  MessageDetailViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/23.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class MessageDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var model: UserModel
    
//    var collection: UICollectionView = {
//       let layout = UICollectionViewFlowLayout()
//        layout.headerReferenceSize = CGSize(width: BBSScreenWidth, height: 200)
//        layout.footerReferenceSize = CGSize(width: BBSScreenWidth, height: 50)
//        layout.itemSize =
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bar = BBSNavigationBar().setTransparentStyle().place(at: self)
        bar.backgroundColor = .clear
        bar.barItem.titleView = {
            let label = UILabel()
            label.text = "BBS"
            label.textColor = UIColorFromRGB(0x222222)
            label.font = UIFont.bbs_defaultFontWith(size: 18)
            label.sizeToFit()
            return label
        }()
        
        let headerView = MessageDetailHeaderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
}
