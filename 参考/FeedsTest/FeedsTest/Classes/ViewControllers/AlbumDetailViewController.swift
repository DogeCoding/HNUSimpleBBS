//
//  AlbumDetailController.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/2.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    var imageView = UIImageView()
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.kf.setImage(with: URL(string: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.snp.makeConstraints{ (make) -> Void in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
