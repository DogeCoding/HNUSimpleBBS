//
//  ScheduleViewController.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/17.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class SheduleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let bgImg = UIImageView(image: UIImage(named: "default_schedule"))
        bgImg.contentMode = .scaleAspectFill
        view.addSubview(bgImg)
        bgImg.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20)
            make.left.right.bottom.equalTo(view)
        }
    }
    
}
