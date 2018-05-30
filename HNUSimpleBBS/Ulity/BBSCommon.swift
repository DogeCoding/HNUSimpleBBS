//
//  BBSCommon.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/15.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import Kingfisher

// MARK: Infomation
let defaultAvatarUrls = ["http://oo8snaf4x.bkt.clouddn.com/doge.jpg",
                        "http://oo8snaf4x.bkt.clouddn.com/1a47fcc17d2e46b5b0d3e0f160d98a0320180123163519.jpg",
                        "http://oo8snaf4x.bkt.clouddn.com/Unknown.jpg",
                        "http://oo8snaf4x.bkt.clouddn.com/1.jpg",
                        "http://oo8snaf4x.bkt.clouddn.com/Zjd3-fyiiahz2863063.jpg",
                        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG11.jpeg",
                        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG14.jpeg",
                        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG12.jpeg",
                        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG13.jpeg"]
//"http://oo8snaf4x.bkt.clouddn.com/avater_placeholder@2x.png"
let defaultAvatarImgPath = "icon_avatarImg"
let defaultImgUrls = [
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG18.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG33.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG31.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG16.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG27.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG17.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG21.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG26.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG28.png",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG22.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG25.png",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG20.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG29.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG32.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG19.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG24.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG30.jpeg",
                     "http://oo8snaf4x.bkt.clouddn.com/WechatIMG23.jpeg"]
let defaultWeiboImgPath = "icon_feed_img"

func defaultAvatarRandom() -> Int {
    return Int(arc4random()%UInt32(defaultAvatarUrls.count))
}
func defaultImgRandom() -> Int {
    return Int(arc4random()%UInt32(defaultImgUrls.count))
}

// MARK: Tips
func AssertMainThread() {
    assert(Thread.current == Thread.main, "This method must be called on the main thread")
}

func AssertFail(_ message: String) {
    assert(false, message)
}



// MARK: NotificationKey
public let BBSTabBarHasBringToFrontNotification = "BBSTabBarHasBringToFrontNotification"



// MARK: PreMethods
public func StringToCGFloat(_ string: String) -> CGFloat {
    let ans = NSString(string: string)
    return CGFloat(ans.floatValue)
}



// MARK: Size
public let BBSScreenBounds = UIScreen.main.bounds

public let BBSScreenScale = UIScreen.main.scale

public let BBSScreenWidth = BBSScreenBounds.width

public let BBSScreenHeight = BBSScreenBounds.height

public let DeviceUUID = NSUUID().uuidString

public let IsIphone_X = UIDevice.current.isIphoneX

public let BBSCurrentSystemVersion: CGFloat = StringToCGFloat(UIDevice.current.systemVersion)

//public 

public let BBSWindows = UIApplication.shared.windows

public let BBSNavigationBarHeight: CGFloat = 44

public let BBSTabbarHeight: CGFloat = 49



// MARK: Color
public func UIColorFromRGB(_ rgbValue: NSInteger) -> UIColor {
    return UIColor.bbs_colorWith(hexValue: rgbValue)
}

public let AppTintColor = UIColorFromRGB(0x43BDCF)      // 主颜色

public let AppTitleColor = UIColorFromRGB(0x222222)     // 导航栏标题颜色

public let BBSStatusBarColor = UIColorFromRGB(0x43BDCF)



// MARK: Instance
public let BBSApplication = UIApplication.shared

let RootViewController = BBSRootViewController.shared

let MyNamespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String



// MARK: Methods
public func showAlretWith(title: String, message: String, by self: UIViewController) -> Void {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
        
    }))
    self.present(alert, animated: true, completion: nil)
}

func dispatch_queue_async_safe(queue: DispatchQueue, _ block: @escaping ()->()) {
    if Thread.current.name == queue.label {
        block()
    } else {
        queue.async {
            block()
        }
    }
}

func dispatch_main_async_safe(_ block: @escaping () -> ()) {
    dispatch_queue_async_safe(queue: DispatchQueue.main) {
        block()
    }
}
