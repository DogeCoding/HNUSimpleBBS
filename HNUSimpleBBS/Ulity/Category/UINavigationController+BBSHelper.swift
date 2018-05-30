//
//  UINavigationController+BBSHelper.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/23.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

extension UINavigationController {
    func popToStackViewController(withClassName name: String, animated: Bool) -> UIViewController {
        var vc = UIViewController()
        guard let cls = NSClassFromString(MyNamespace+"."+name) else {
            return vc
        }
        for tvc in viewControllers {
            if tvc.isKind(of: cls) {
                popToViewController(tvc, animated: animated)
                vc = tvc
            }
        }
        return vc
    }
}
