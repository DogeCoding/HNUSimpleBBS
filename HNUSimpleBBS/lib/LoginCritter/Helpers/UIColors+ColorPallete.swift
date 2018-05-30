//
//  UIColors+ColorPallete.swift
//  LoginCritter
//
//  Created by Christopher Goldsby on 3/30/18.
//  Copyright © 2018 Christopher Goldsby. All rights reserved.
//

import UIKit

// MARK: - Color Pallete

extension UIColor {
    static let loginLight = #colorLiteral(red: 0.768627451, green: 1, blue: 0.9764705882, alpha: 1)
    static let loginDark = UIColorFromRGB(0x43BDCF)
    static let loginText = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    static let loginDisabledText = UIColor.loginText.withAlphaComponent(0.8)
}
// #colorLiteral(red: 0.02745098039, green: 0.7450980392, blue: 0.7215686275, alpha: 1)
