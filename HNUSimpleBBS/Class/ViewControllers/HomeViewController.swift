//
//  HomeViewController.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

//import 

class HomeViewController: ASViewController<ASCollectionNode> {
    
    var data = HomeFeedModel()
    
    var collectionNode: ASCollectionNode? = nil
    
    init() {
        let layout = UICollectionViewLayout()
        let node = ASCollectionNode.init(collectionViewLayout: layout)
        super.init(node: node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
