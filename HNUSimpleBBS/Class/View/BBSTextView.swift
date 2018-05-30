////
////  BBSTextView.swift
////  HNUSimpleBBS
////
////  Created by CodingDoge on 2018/5/30.
////  Copyright © 2018年 CodingDoge. All rights reserved.
////
//
//class BBSTextView: UITextView {
//
//    var placeholder: String {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//    
//    var placeholderColor: UIColor {
//        didSet {
//            
//        }
//    }
//    
//    init() {
//        placeholder = "Please input something..."
//        placeholderColor = .lightGray
//        super.init(frame: .zero)
//        
//    }
//    
//    override func draw(_ rect: CGRect) {
//        var attrs: [NSAttributedStringKey : Any] = [:]
//        attrs[.font] = font
//        attrs[.foregroundColor] = placeholderColor
//        
//        let attrStr = NSAttributedString(string: placeholder, attributes: attrs)
//        placeholder = attrStr.string
//        placeholder.draw(with: CGRect(x: 0, y: 0, width: width(), height: height()), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
//        
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        setNeedsDisplay()
//    }
//    
//    override var text: String! {
//        get {
//            return super.text
//        }
//        set {
//            super.text = newValue
//        }
//    }
//    
//    
//}
