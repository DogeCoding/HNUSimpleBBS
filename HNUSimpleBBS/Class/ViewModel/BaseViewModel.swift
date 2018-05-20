//
//  BaseViewModel.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let defaultUserName = "codingdoge"

class BaseViewModel: NSObject, ListDiffable {
    
    var data: Any
    
    var requestUrl: String
    
    var requestCompletionBlock: () -> ()
    
    var userName: String
    
    var message: String
    
    var timeSincePost: String
    
    fileprivate var fetchDatasInProgress: Bool = false
    fileprivate var refreshFeedInProgress: Bool = false
    
    override init() {
        data = (Any).self
        requestUrl = ""
        requestCompletionBlock = {}
        userName = defaultUserName
        message = "There are no new messages."
        timeSincePost = "2018-1-1"
    }
    
    // MARK: Remote Data
    func requestDatas(withCompletionBlock block: (Array<Any>) -> (), numResuletsToReturn numResults: NSInteger) {
        if fetchDatasInProgress {
            return
        } else {
            fetchDatasInProgress = true
            fetchDatas(withCompletionBlock: block, numResultsToReturn: numResults)
        }
    }
    
    fileprivate func fetchDatas(withCompletionBlock block: (Array<Any>) -> (), numResultsToReturn numResults: NSInteger) {
        fetchDatas(withCompletionBlock: block, numResultsToreturn: numResults, isReplaceData: false)
    }
    
    fileprivate func fetchDatas(withCompletionBlock block: (Array<Any>) -> (), numResultsToreturn numResults: NSInteger, isReplaceData: Bool) {
        
    }
    
    // MARK: UI Data
    func userNameAttributedString(withFontSize size: CGFloat) -> NSAttributedString {
        return NSAttributedString.attributedStringWith(string: userName, fontSize: size, color: UIColor.darkBlueColor())
    }
    
    func messageAttributedString(withFontSize size: CGFloat) -> NSAttributedString {
        return NSAttributedString.attributedStringWith(string: message, fontSize: size, color: UIColor.darkGray)
    }
    
    func timeSincePostAttributedString(withFontSize size: CGFloat) -> NSAttributedString {
        return NSAttributedString.attributedStringWith(string: timeSincePost, fontSize: size, color: UIColor.lightGray)
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
