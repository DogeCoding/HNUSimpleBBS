//
//  FeedHeaderNode.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/20.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let kFeedHeaderInset = UIEdgeInsetsMake(20, 20, 10, 10)

class FeedHeaderNode: ASCellNode {
    
    var textNode: ASTextNode
    
    override init() {
        textNode = ASTextNode()
        super.init()
        automaticallyManagesSubnodes = true
        textNode.attributedText = NSAttributedString.attributedStringWith(string: "CollectionNode Header", fontSize: 18, color: UIColor.darkGray)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: kFeedHeaderInset, child: textNode)
    }
    
}
