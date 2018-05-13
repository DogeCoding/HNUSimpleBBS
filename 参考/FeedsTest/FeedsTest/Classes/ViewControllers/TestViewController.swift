//
//  TestViewController.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/2.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(click))
        let sc = UIScrollView()
        sc.backgroundColor = .yellow
        view.addSubview(sc)
        sc.snp.makeConstraints{ (make) -> Void in
            make.top.bottom.left.right.equalToSuperview()
        }
        sc.mj_header = MJRefreshNormalHeader() { [weak self] () -> Void in
            guard let `self` = self else { return }
            print("2 \(sc.mj_header)")
            sleep(2)
            sc.mj_header.endRefreshing()
            
        }
        
    }
    
    @objc func click() {
        print("test")
    }
    
}
