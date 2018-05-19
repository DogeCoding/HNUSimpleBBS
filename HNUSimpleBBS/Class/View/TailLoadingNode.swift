//
//  TailLoadingNode.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/19.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class TailLoadingNode: ASCellNode {
    fileprivate var activityIndicatorNode: ASDisplayNode
    
    override init() {
        activityIndicatorNode = ASDisplayNode(viewBlock: { () -> UIView in
            let v = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            v.startAnimating()
            return v
        })
        super.init()
        style.height = ASDimensionMake(100)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: activityIndicatorNode)
    }
}
