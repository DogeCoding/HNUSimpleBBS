//
//  PersonViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//


class MineViewController: UIViewController {
    
    override func viewDidLoad() {
        let button = TransitionButton(frame: CGRect(x: (BBSScreenWidth-200)/2, y: BBSScreenHeight-40-80, width: 200, height: 40))
        button.addTarget(self, action: #selector(handleClickBtn(sender:)), for: .touchUpInside)
        button.backgroundColor = .red
        button.setTitle("Button", for: .normal)
        button.cornerRadius = 20
        button.spinnerColor = .white
        view.addSubview(button)
    }
    
    @objc func handleClickBtn(sender: TransitionButton) {
        sender.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async {
            sleep(3)
            
            DispatchQueue.main.async(execute: {
                sender.stopAnimation(animationStyle: .expand,
                                     revertAfterDelay: 2,
                                     completion: {
                                        
                })
            })
        }
    }
    
}
