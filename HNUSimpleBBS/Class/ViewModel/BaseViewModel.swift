//
//  BaseViewModel.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class BaseViewModel: NSObject, ListDiffable {
    
    var data: Any
    
    var requestUrl: String
    
    var requestCompletionBlock: () -> ()
    
    override init() {
        data = (Any).self
        requestUrl = ""
        requestCompletionBlock = {}
    }
    
    
    func fetchRemoteData() -> () {
        
    }
    
    // MARK: ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? BaseViewModel {
            return self == object
        }
        return false
    }
    
}
