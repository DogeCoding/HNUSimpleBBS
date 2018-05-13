//
//  Network.swift
//  FeedsTest
//
//  Created by CodingDoge on 2017/12/31.
//  Copyright © 2017年 CodingDoge. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// API参数 device_id 对应 IID
let BASE_URL = "https://is.snssdk.com/"
let device_id: String = "6096495334"
let IID: String = "5034850950"
let versionCode = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

class Network {
    
//    let BASE_URL = "http://lf.snssdk.com/"
//    let BASE_URL = "http://ib.snssdk.com"
    
    // 根据category的不同请求不同数据
    class func loadCategoryNewsFeeds(category: String, completionHandler:@escaping (_ nowTime: TimeInterval,_ newsFeeds: [BaseModel])->()) {
        let url = BASE_URL + "api/news/feed/v58/?"
        let params = ["device_id": device_id,
                      "category": category,
                      "iid": IID,
                      "device_platform": "iphone",
                      "version_code": versionCode]
        let nowTime = NSDate().timeIntervalSince1970
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                // 需要处理
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard let dataJSONs = json["data"].array else {
                    return
                }
                var feeds = [BaseModel]()
                for data in dataJSONs {
                    if let content = data["content"].string {
                        let contentData: NSData = content.data(using: String.Encoding.utf8)! as NSData
                        do {
                            let dict = try JSONSerialization.jsonObject(with: contentData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            let feed = BaseModel(dict: dict as! [String : AnyObject])
                            feeds.append(feed)

                        } catch {

                        }
                    }
                }
                completionHandler(nowTime, feeds)
            }
        }
    }
    
    // 解析html 暂时没加上
    class func loadCommenNewsDetail(articleURL: String, completionHandler:@escaping (_ htmlString: String, _ images: [NewsDetailImage], _ abstracts: [String])->()) {
        // 测试数据
        Alamofire.request(articleURL).responseString { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                var images = [NewsDetailImage]()
                var abstracts = [String]()
                var htmlString = String()
                if value.contains("BASE_DATA.galleryInfo =") { // 则是图文详情
                    // 获取 图片链接数组
                    let startIndex = value.range(of: "\"sub_images\":")!.upperBound
                    let endIndex = value.range(of: ",\"max_img_width\"")!.lowerBound
                    let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
                    let BASE_DATA = value.substring(with: range)
                    let data = BASE_DATA.data(using: String.Encoding.utf8)! as Data
                    let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [AnyObject]
                    for image in dict! {
                        let img = NewsDetailImage(dict: image as! [String: AnyObject])
                        images.append(img)
                    }
                    // 获取 子标题
                    let titleStartIndex = value.range(of: "\"sub_abstracts\":")!.upperBound
                    let titlEndIndex = value.range(of: ",\"sub_titles\"")!.lowerBound
                    let titleRange = Range(uncheckedBounds: (lower: titleStartIndex, upper: titlEndIndex))
                    let sub_abstracts = value.substring(with: titleRange)
                    let titleData = sub_abstracts.data(using: String.Encoding.utf8)! as Data
                    let subAbstracts = try? JSONSerialization.jsonObject(with: titleData, options: .mutableContainers) as! [String]
                    for string in subAbstracts! {
                        abstracts.append(string)
                    }
                } else if value.contains("articleInfo: ") { // 一般的新闻
                    // 获取 新闻内容
                    let startIndex = value.range(of: "content: '")!.upperBound
                    let endIndex = value.range(of: "'.replace")!.lowerBound
                    let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
                    let content = value.substring(with: range)
                    let contentDecode = Network.htmlDecode(content: content)
                    /// 创建 html
                    var html = "<!DOCTYPE html>"
                    html += "<html>"
                    html += "<head>"
                    html += "<meta charset=utf-8>"
                    html += "<meta content='width=device-wdith,initial-scale=1.0,maximum-scale=3.0,user-scalabel=0;' name='viewport' />"
                    html += "<link rel=\"stylesheet\" type=\"text/css\" href=\"news.css\" />\n"
                    html += "</head>"
                    html += "<body>"
                    html += contentDecode
                    html += "</body>"
                    html += "<div></div>"
                    html += "</html>"
                    htmlString = html
                } else { // 第三方的新闻内容
                    /// 这部分显示还有问题
                    htmlString = value
                }
                completionHandler(htmlString, images, abstracts)
            }
        }
    }
    
    class func htmlDecode(content: String) -> String {
        var s = String()
        s = content.replacingOccurrences(of: "&amp;", with: "&")
        s = s.replacingOccurrences(of: "&lt;", with: "<")
        s = s.replacingOccurrences(of: "&gt;", with: ">")
        s = s.replacingOccurrences(of: "&nbsp;", with: " ")
        s = s.replacingOccurrences(of: "&#39;", with: "\'")
        s = s.replacingOccurrences(of: "&quot;", with: "\"")
        s = s.replacingOccurrences(of: "<br>", with: "\n")
        return s
    }
    
}
