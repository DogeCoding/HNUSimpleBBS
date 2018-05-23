//
//  BaseViewModel.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/4/8.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

enum ViewModelDataType: Int {
    case weibo = 0,
    user
}

class BaseViewModel: NSObject, ListDiffable {

    var datas: [ListDiffable]

    var requestUrl: String
    
    var requestCompletionBlock: () -> ()
        
    fileprivate var isFetchDatasInProgress: Bool = false
    fileprivate var isRefreshFeedInProgress: Bool = false
    
    override init() {
        datas = []
        requestUrl = ""
        requestCompletionBlock = {}
    }
    
    // MARK: Remote Data
    func requestDatas(withDataType dataType: ViewModelDataType, _ completionBlock: @escaping (Array<Any>) -> ()) {
        if isFetchDatasInProgress {
            return
        } else {
            isFetchDatasInProgress = true
            fetchDatas(withDataType: dataType, completionBlock)
        }
    }
    
    fileprivate func fetchDatas(withDataType dataType: ViewModelDataType, _ completionBlock: @escaping (Array<Any>) -> ()) {
        fetchDatas(withDataType: dataType, isReplaceData: false, completionBlock)
    }
    
    fileprivate func fetchDatas(withDataType dataType: ViewModelDataType, isReplaceData: Bool, _ completionBlock: @escaping (Array<Any>) -> ()) {
//        sleep(3)
        switch dataType {
        case .weibo:
            for i in 0..<4 {
                let model = WeiboModel()
                model.userID = i
                datas.append(model)
            }
        case .user:
            for i in 0..<10 {
                let model = UserModel()
                datas.append(model)
            }
        }
        
        completionBlock(datas)
        isFetchDatasInProgress = false
    }
    
    func refreshDatas(withDataType dataType: ViewModelDataType, _ completionBlock: @escaping (Array<Any>) -> ()) {
        if isRefreshFeedInProgress {
            return
        } else {
            isRefreshFeedInProgress = true
            fetchDatas(withDataType: dataType, isReplaceData: true) { (newModels) in
                completionBlock(newModels)
                self.isRefreshFeedInProgress = false
            }
        }
    }
    
    // MARK: ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BaseViewModel else { return false }
        return self == object
    }
}
