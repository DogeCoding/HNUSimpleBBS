//
//  SegmentioBuilder.swift
//  FeedsTest
//
//  Created by CodingDoge on 2017/12/29.
//  Copyright © 2017年 CodingDoge. All rights reserved.
//

import Segmentio
import UIKit

// Segmentio三方的订制
fileprivate struct ColorPalette {
    
    static let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static let black = UIColor(red: 3.0/255, green: 3/255, blue: 3/255, alpha: 1)
    static let coral = UIColor(red: 244/255, green: 111/255, blue: 96/255, alpha: 1)
    static let whiteSmoke = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    static let grayChateau = UIColor(red: 163/255, green: 164/255, blue: 168/255, alpha: 1)
    
}

extension UIFont {
    
    class func exampleAvenirMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Book", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func exampleAvenirLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

class FTSegmentioView: Segmentio {
    
    var segmentioHeight: CGFloat = 0
    
    func setupBadgeCountForIndex(index: Int) {
        addBadge(
            at: index,
            count: 10,
            color: ColorPalette.coral
        )
    }
    
    func build() {
        let content = [
            SegmentioItem(title: "军事", image: UIImage(named: "hot.png")),
            SegmentioItem(title: "图片", image: UIImage(named: "album.png")),
            SegmentioItem(title: "段子", image: UIImage(named: "society.png"))
        ]
        
        let segmentioIndicatorOptions = SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 4,
            color: ColorPalette.coral
        )
        
        let segmentioHorizontalSeparatorOptions = SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 1,
            color: ColorPalette.whiteSmoke
        )
        
        let segmentioVerticalSeparatorOptions = SegmentioVerticalSeparatorOptions(
            ratio: 1,
            color: ColorPalette.whiteSmoke
        )
        
        let font = UIFont.exampleAvenirMedium(ofSize: 13)
        let segmentioStates = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: .clear,
                titleFont: font,
                titleTextColor: ColorPalette.grayChateau
            ),
            selectedState: SegmentioState(
                backgroundColor: .white,
                titleFont: font,
                titleTextColor: ColorPalette.black
            ),
            highlightedState: SegmentioState(
                backgroundColor: ColorPalette.whiteSmoke,
                titleFont: font,
                titleTextColor: ColorPalette.grayChateau
            )
        )
        
        let segmentioOptions = SegmentioOptions(
            backgroundColor: ColorPalette.white,
            maxVisibleItems: 3,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions,
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions,
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions,
            imageContentMode: .scaleAspectFit,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
            segmentStates: segmentioStates,
            animationDuration: 0.3
        )
        
        setup(content: content, style: .imageAfterLabel, options: segmentioOptions)
    }
}
