//
//  iToast.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/21.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

enum iToastGravity: NSInteger {
    case top = 1000001,
    bottom,
    center
}

enum iToastDuration: TimeInterval {
    case long = 10000,
    short = 1000,
    normal = 3000
}

enum iToastType: NSInteger {
    case info = -100000,
    notice,
    warning,
    error,
    none
}

enum iToastImageLocation {
    case top,
    left
}

class iToastSettings: NSObject {
    var duration: iToastDuration
    var gravity: iToastGravity
    var position: CGPoint
    fileprivate var toastType: iToastType
    var fontSize: CGFloat
    var isUseShadow: Bool
    var cornerRadius: CGFloat
    var bgRed: CGFloat
    var bgGreen: CGFloat
    var bgBlue: CGFloat
    var bgAlpha: CGFloat
    var offsetLeft: CGFloat
    var offsetTop: CGFloat
    var images: [String : UIImage]
    fileprivate var isPositionSet: Bool
    var imageLocation: iToastImageLocation
    
    static let shared = iToastSettings().then { _ in
        
    }
    
    fileprivate override init() {
        duration = .normal
        gravity = .center
        position = .zero
        toastType = .info
        fontSize = 16
        isUseShadow = false
        cornerRadius = 18
        bgRed = 0
        bgGreen = 0
        bgBlue = 0
        bgAlpha = 0.3
        offsetLeft = 0
        offsetTop = 0
        images = [:]
        isPositionSet = false
        imageLocation = .top
        super.init()
    }
    
    func set(image: UIImage, forType type: iToastType) {
        
        set(image: image, withLocation: .left, forType: type)
    }
    
    func set(image: UIImage, withLocation location: iToastImageLocation, forType type: iToastType) {
        if type == .none {
            return
        }
        let key = String(type.rawValue)
        images[key] = image
        
        imageLocation = location
    }
}

fileprivate let kComponentPadding: CGFloat = 9
fileprivate let CURRENT_TOAST_TAG: NSInteger = 6984678
class iToast: NSObject {
    fileprivate var settings: iToastSettings
    fileprivate var timer: Timer
    fileprivate var view: UIView
    fileprivate var text: String
    
    init(withText: String) {
        settings = iToastSettings.shared
        timer = Timer()
        view = UIView()
        text = withText
        super.init()
    }
    
    class func makeText(_ _text: String) -> iToast {
        return iToast(withText: _text)
    }
    
    func set(gravity: iToastGravity, offsetLeft left: CGFloat, offsetTop top: CGFloat) {
        settings.gravity = gravity
        settings.offsetLeft = left
        settings.offsetTop = top
    }
    
    func show() {
        show(withType: .info)
    }
    
    func show(withType type: iToastType) {
        if text.count == 0 { return }
        let image = settings.images[String(type.rawValue)]
        let font = UIFont.bbs_defaultFontWith(size: settings.fontSize)
        let attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.font : font])
        let rect = attributedText.boundingRect(with: CGSize(width: 280, height: 60), options: .usesLineFragmentOrigin, context: nil)
        let textSize = rect.size
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: textSize.width + kComponentPadding, height: textSize.height + kComponentPadding))
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = font
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        if settings.isUseShadow {
            label.shadowColor = .darkGray
            label.shadowOffset = CGSize(width: 1, height: 1)
        }
        
        let btn = UIButton(type: .custom)
        if let image = image {
            btn.frame = toastFrame(forImageSize: image.size, withLocation: settings.imageLocation, andTextSize: textSize)
            
            switch settings.imageLocation {
            case .left:
                label.textAlignment = .left
                label.center = CGPoint(x: image.size.width + kComponentPadding * 2 + (btn.frame.size.width - image.size.width - kComponentPadding * 2) / 2,
                                       y: btn.frame.size.height / 2)
                
            case .top:
                label.textAlignment = .center
                label.center = CGPoint(x: btn.frame.size.width / 2,
                                       y: (image.size.height + kComponentPadding * 2 + (btn.frame.size.height - image.size.height - kComponentPadding * 2) / 2))
            }
        } else {
            btn.frame = CGRect(x: 0, y: 0, width: textSize.width + kComponentPadding * 2, height: textSize.height + kComponentPadding * 2)
            label.center = CGPoint(x: btn.frame.size.width / 2, y: btn.frame.size.height / 2)
        }
        var lbfrm = label.frame
        lbfrm.origin.x = ceil(lbfrm.origin.x)
        lbfrm.origin.y = ceil(lbfrm.origin.y)
        label.frame = lbfrm
        btn.addSubview(label)
        
        if let image = image {
            let imageView = UIImageView(image: image)
            imageView.frame = frameForImage(withType: type, inToastFrame: btn.frame)
            btn.addSubview(imageView)
        }
        
        btn.backgroundColor = UIColor(red: settings.bgRed, green: settings.bgGreen, blue: settings.bgBlue, alpha: settings.bgAlpha)
        btn.layer.cornerRadius = settings.cornerRadius
        var fixedOffset: CGFloat = 184
        if IsIphone_X {
            fixedOffset = 220
        }
        
        guard let window = BBSWindows.first else { return }
        var point = CGPoint.zero
        switch settings.gravity {
        case .top:
            point = CGPoint(x: window.frame.size.width / 2, y: fixedOffset)
        case .bottom:
            point = CGPoint(x: window.frame.size.width / 2 , y: window.frame.size.height - fixedOffset)
        case .center:
            point = CGPoint(x: window.frame.size.width / 2, y: window.frame.size.height / 2)
        }
        point = CGPoint(x: point.x + settings.offsetLeft, y: point.y + settings.offsetTop)
        btn.center = point
        
        timer = Timer(timeInterval: settings.duration.rawValue / 2000, target: self, selector: #selector(hideToast(theTimer:)), userInfo: nil, repeats: false)
        RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
        
        btn.tag = CURRENT_TOAST_TAG
        
        if let currentToast = window.viewWithTag(CURRENT_TOAST_TAG) {
            currentToast.removeFromSuperview()
        }
        
        btn.alpha = 0
        window.addSubview(btn)
        UIView.beginAnimations(nil, context: nil)
        btn.alpha = 1
        UIView.commitAnimations()
        
        view = btn
        btn.addTarget(self, action: #selector(hideToast(theTimer:)), for: .touchDown)
    }
    
    fileprivate func toastFrame(forImageSize imageSize: CGSize, withLocation location: iToastImageLocation, andTextSize textSize: CGSize) -> CGRect {
        var theRect = CGRect.zero
        switch location {
        case .left:
            theRect = CGRect(x: 0, y: 0, width: imageSize.width + textSize.width + kComponentPadding * 3, height: max(textSize.height, imageSize.height) + kComponentPadding * 2)
            
        case .top:
            theRect = CGRect(x: 0, y: 0, width: max(textSize.width, imageSize.width) + kComponentPadding * 2, height: imageSize.height + textSize.height + kComponentPadding * 3)
        }
        return theRect
    }
    
    fileprivate func frameForImage(withType type: iToastType, inToastFrame toastFrame: CGRect) -> CGRect {
        guard let image = settings.images[String(type.rawValue)] else { return .zero }
        var imageFrame = CGRect.zero
        switch settings.imageLocation {
        case .left:
            imageFrame = CGRect(x: kComponentPadding, y: (toastFrame.size.height - image.size.height) / 2, width: image.size.width, height: image.size.height)
        case .top:
            imageFrame = CGRect(x: (toastFrame.size.width - image.size.width) / 2, y: kComponentPadding, width: image.size.width, height: image.size.height)
        }
        return imageFrame
    }
    
    @objc fileprivate func hideToast(theTimer: Timer) {
        UIView.beginAnimations(nil, context: nil)
        view.alpha = 0
        UIView.commitAnimations()
        
        let timer2 = Timer(timeInterval: 500, target: self, selector: #selector(hideToast(theTimer:)), userInfo: nil, repeats: false)
        RunLoop.main.add(timer2, forMode: .defaultRunLoopMode)
    }
}
