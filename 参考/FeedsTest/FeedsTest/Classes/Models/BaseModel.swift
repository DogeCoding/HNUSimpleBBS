//
//  BaseModel.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/1.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit
import IGListKit

// 基础model 从网络抓取 使用SwiftyJSON解析
class BaseModel {
    
    var content: String?
    var title: NSString = ""
    var has_image: Bool?
    var has_video: Bool?
    var article_sub_type: Int?
    var article_type: Int?
    var article_url: String?
    
    var large_image: FTDetailVideoLargeImage?
    var image_list = [FTImageList]()
    var large_image_list = [FTLargeImageList]()
    var middle_image: FTMiddleImage?
    var video_detail_info: FTVideoDetailInfo?
    var thumb_image_list = [FTThumbImageList]()
    
    init(dict: [String: AnyObject]) {
        content = dict["content"] as? String
        if let title = dict["title"] as? NSString {
            self.title = title
        }
        has_image = dict["has_image"] as? Bool
        has_video = dict["has_video"] as? Bool
        article_sub_type = dict["article_sub_type"] as? Int
        article_type = dict["article_type"] as? Int
        article_url = dict["article_url"] as? String
        
        if let largeImage = dict["large_image"] as? [String: AnyObject] {
            large_image = FTDetailVideoLargeImage(dict: largeImage)
        }
        
        if let imageList = dict["image_list"] as? [AnyObject] {
            for item in imageList {
                let image = FTImageList(dict: item as! [String: AnyObject])
                image_list.append(image)
            }
        }
        
        if let largeImageList = dict["large_image_list"] as? [AnyObject] {
            for item in largeImageList {
                let largeImage = FTLargeImageList(dict: item as! [String: AnyObject])
                large_image_list.append(largeImage)
            }
        }
        
        if let middleImage = dict["middle_image"] as? [String: AnyObject] {
            middle_image = FTMiddleImage(dict: middleImage)
        }
        
        if let videoDetailInfo = dict["video_detail_info"] as? [String: AnyObject] {
            video_detail_info = FTVideoDetailInfo(dict: videoDetailInfo)
        }
        
        if let thumbImageList = dict["thumb_image_list"] as? [AnyObject] {
            for item in thumbImageList {
                let thumbImage = FTThumbImageList(dict: item as! [String: AnyObject])
                thumb_image_list.append(thumbImage)
            }
        }
    }
}

extension BaseModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        
        if let url = large_image?.url {
            return url as NSObjectProtocol
        } else if let content = content {
            return content as NSObjectProtocol
        }
        return title as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? BaseModel else { return false }
        if let urlL = large_image?.url, let urlR = object.large_image?.url {
            return urlL == urlR
        } else if let contentL = content, let contentR = object.content {
            return contentL == contentR
        }
        return title == object.title
    }
}

class FTDetailVideoLargeImage {
    
    var height: CGFloat?
    var width: CGFloat?
    
    var url: String?
    
    var url_list = [FTURLList]()
    
    init(dict: [String: AnyObject]) {
        
        height = dict["height"] as? CGFloat
        width = dict["width"] as? CGFloat
        url = dict["url"] as? String
        if let urllists = dict["url_list"] as? [AnyObject] {
            for urlDict in urllists {
                let ftURLList = FTURLList(dict: urlDict as! [String: AnyObject])
                url_list.append(ftURLList)
            }
        }
    }
}

class FTURLList {
    
    var url: String?
    
    init(dict: [String: AnyObject]) {
        url = dict["url"]  as? String
    }
}

class FTImageList {
    
    var height: CGFloat?
    var width: CGFloat?
    
    var type: Int?
    
    var url: String?
    
    var url_list = [FTURLList]()
    
    init(dict: [String: AnyObject]) {
        type = dict["type"] as? Int
        height = dict["height"] as? CGFloat
        width = dict["width"] as? CGFloat
        if let urlString = dict["url"] as? String {
            if urlString.hasSuffix(".webp") {
                let index = urlString.index(urlString.endIndex, offsetBy: -5)
                url = urlString.substring(to: index)
            } else {
                url = urlString as String
            }
        }
        if let urllists = dict["url_list"] as? [AnyObject] {
            for urlDict in urllists {
                let ftURLList = FTURLList(dict: urlDict as! [String: AnyObject])
                url_list.append(ftURLList)
            }
        }
    }
}

class FTLargeImageList {
    
    var height: CGFloat?
    var width: CGFloat?
    
    var type: Int?
    
    var uri: String?
    
    var url: String?
    
    var url_list = [FTURLList]()
    
    init(dict: [String: AnyObject]) {
        height = dict["height"] as? CGFloat
        width = dict["width"] as? CGFloat
        type = dict["type"] as? Int
        uri = dict["uri"] as? String
        url = dict["url"] as? String
        if let urllists = dict["url_list"] as? [AnyObject] {
            for urlDict in urllists {
                let ftURLList = FTURLList(dict: urlDict as! [String: AnyObject])
                url_list.append(ftURLList)
            }
        }
    }
}

class FTMiddleImage {
    
    var height: CGFloat?
    var width: CGFloat?
    
    var url: String?
    
    var url_list = [FTURLList]()
    
    init(dict: [String: AnyObject]) {
        
        height = dict["height"] as? CGFloat
        width = dict["width"] as? CGFloat
        if let urlString = dict["url"] as? String {
            if urlString.hasSuffix(".webp") {
                let index = urlString.index(urlString.endIndex, offsetBy: -5)
                url = urlString.substring(to: index)
            } else {
                url = urlString as String
            }
        }
        if let urllists = dict["url_list"] as? [AnyObject] {
            for urlDict in urllists {
                let ftURLList = FTURLList(dict: urlDict as! [String: AnyObject])
                url_list.append(ftURLList)
            }
        }
    }
}

class FTVideoDetailInfo {
    
    var direct_play: Int?
    var group_flags: Int?
    var show_pgc_subscribe: Int?
    var video_id: String?
    var video_preloading_flag: Bool?
    var video_type: Int?
    var video_watch_count: Int?
    var video_watching_count: Int?
    var videoWatchCount: String? {
        guard let count = video_watch_count else {
            return "0"
        }
        guard count >= 10000 else {
            return String(describing: count)
        }
        return String(format: "%.1f万", Float(count) / 10000.0)
    }
    
    var detail_video_large_image: FTDetailVideoLargeImage?
    
    init(dict: [String: AnyObject]) {
        
        video_watching_count = dict["video_watching_count"] as? Int
        video_watch_count = dict["video_watch_count"] as? Int
        video_type = dict["video_type"] as? Int
        video_preloading_flag = dict["video_preloading_flag"] as? Bool
        video_id = dict["video_id"] as? String
        direct_play = dict["direct_play"] as? Int
        group_flags = dict["group_flags"] as? Int
        show_pgc_subscribe = dict["show_pgc_subscribe"] as? Int
        if let detailVideoLargeImage = dict["detail_video_large_image"] as? [String: AnyObject] {
            detail_video_large_image = FTDetailVideoLargeImage(dict: detailVideoLargeImage)
        }
    }
}

class FTThumbImageList {
    
    var height: CGFloat?
    var width: CGFloat?
    
    var type: Int?
    
    var uri: String?
    
    var url: String?
    
    var url_list = [FTURLList]()
    
    init(dict: [String: AnyObject]) {
        height = dict["height"] as? CGFloat
        width = dict["width"] as? CGFloat
        type = dict["type"] as? Int
        uri = dict["uri"] as? String
        url = dict["url"] as? String
        if let urllists = dict["url_list"] as? [AnyObject] {
            for urlDict in urllists {
                let ftURLList = FTURLList(dict: urlDict as! [String: AnyObject])
                url_list.append(ftURLList)
            }
        }
    }
}
