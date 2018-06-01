//
//  WeiboCellNode.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/19.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let __USER_AVATAR_LENGTH: CGFloat = 50
fileprivate let __FONT_SIZE: CGFloat = 14
fileprivate let HORIZONTAL_BUFFER: CGFloat = 10
fileprivate let VERTICAL_BUFFER: CGFloat = 5
fileprivate let __PHOTO_WIDTH = (BBSScreenWidth-HORIZONTAL_BUFFER*4)/3
fileprivate let __PHOTO_HEIGHT: CGFloat = 100
fileprivate let InsetForAvatar = UIEdgeInsetsMake(HORIZONTAL_BUFFER, 0, HORIZONTAL_BUFFER, HORIZONTAL_BUFFER)
fileprivate let InsetForHeader = UIEdgeInsetsMake(0, 0, 0, HORIZONTAL_BUFFER)
fileprivate let InsetForFooter = UIEdgeInsetsMake(VERTICAL_BUFFER, 0, 0, -HORIZONTAL_BUFFER)
fileprivate let InsetForLine = UIEdgeInsetsMake(0, 0, 0, -HORIZONTAL_BUFFER)

class WeiboCellNode: ASCellNode, ASNetworkImageNodeDelegate {
    
    fileprivate var model: WeiboModel
    
    fileprivate var userAvatarImageNode: ASNetworkImageNode
    
    fileprivate var photoImageNodes: [ASNetworkImageNode] = []
    
    lazy fileprivate var userNameLabel: ASTextNode = ASTextNode()
    
    lazy fileprivate var feedTimePostLabel: ASTextNode = ASTextNode()
    
    lazy fileprivate var feedMessageLabel: ASTextNode = ASTextNode()
    
    lazy fileprivate var lineView: ASDisplayNode = ASDisplayNode()
    
    init(weiboModel: WeiboModel) {
        model = weiboModel
        
        userAvatarImageNode = ASNetworkImageNode()
        userAvatarImageNode.url = URL(string: model.userAvatarUrl)
        userAvatarImageNode.defaultImage = UIImage(named: model.defaultAvatarImg)
        userAvatarImageNode.placeholderEnabled = true
        userAvatarImageNode.placeholderFadeDuration = 1
        userAvatarImageNode.imageModificationBlock = { (image) in
            return image.makeCircularImageWith(size: CGSize(width: __USER_AVATAR_LENGTH, height: __USER_AVATAR_LENGTH))
        }
        
        super.init()
        
        userNameLabel = creatLayerBackedTextNodeWith(attributedString: model.userNameAttributedString(withFontSize: __FONT_SIZE))
        
        feedTimePostLabel = creatLayerBackedTextNodeWith(attributedString: model.timeSincePostAttributedString(withFontSize: __FONT_SIZE))
        
        feedMessageLabel = creatLayerBackedTextNodeWith(attributedString: model.messageAttributedString(withFontSize: __FONT_SIZE))
        feedMessageLabel.maximumNumberOfLines = 0
        
        for url in model.imgUrls {
            let imageNode = ASNetworkImageNode()
            imageNode.delegate = self
            imageNode.url = URL(string: url)
            imageNode.isLayerBacked = false
            imageNode.defaultImage = UIImage(named: model.dafaultImgPath)
            imageNode.placeholderEnabled = true
            imageNode.placeholderFadeDuration = 1
            imageNode.addTarget(self, action: #selector(handleClickImgeNode(sender:)), forControlEvents: .touchUpInside)
            photoImageNodes.append(imageNode)
        }
        
        lineView.backgroundColor = UIColorFromRGB(0x333333)
        
        automaticallyManagesSubnodes = true
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var headerChildren: Array<ASLayoutElement> = []
        var verticalChildren: Array<ASLayoutElement> = []
        
        let headerStack = ASStackLayoutSpec()
        headerStack.direction = .horizontal
        headerStack.alignItems = .center
        userAvatarImageNode.style.preferredSize = CGSize(width: __USER_AVATAR_LENGTH, height: __USER_AVATAR_LENGTH)
        headerChildren.append(ASInsetLayoutSpec(insets: InsetForAvatar, child: userAvatarImageNode))
        
        let userInfoStack = ASStackLayoutSpec()
        userInfoStack.direction = .vertical
        userInfoStack.style.flexGrow = 1
        headerChildren.append(userInfoStack)
        
        userNameLabel.style.flexGrow = 1
        userInfoStack.children = [userNameLabel]
        
        feedTimePostLabel.style.flexGrow = 1
        userInfoStack.children?.append(feedTimePostLabel)
        
        headerStack.children = headerChildren
        
        let footerStack = ASStackLayoutSpec()
        footerStack.direction = .horizontal
        footerStack.spacing = HORIZONTAL_BUFFER
        for imageNode in photoImageNodes {
            imageNode.style.flexGrow = 1
        }
        for photo in photoImageNodes {
            photo.style.preferredSize = CGSize(width: __PHOTO_WIDTH, height: __PHOTO_HEIGHT)
        }
        footerStack.children = [photoImageNodes[0]]
        for i in 1..<photoImageNodes.count {
            footerStack.children?.append(photoImageNodes[i])
        }
        
        feedMessageLabel.style.preferredSize = CGSize(width: BBSScreenWidth-HORIZONTAL_BUFFER*2, height: __FONT_SIZE+3)
        
        lineView.style.preferredSize = CGSize(width: BBSScreenWidth-HORIZONTAL_BUFFER*2, height: 1/BBSScreenScale)
//
//        var footerItems: Array<ASLayoutElement> = []
//        for i in 0..<photoImageNodes.count {
//            photoImageNodes[i].style.preferredSize = CGSize(width: __PHOTO_WIDTH, height: __PHOTO_HEIGHT)
//            if i < 3 {
//                var ratio: CGFloat = 1
//
//                if let image = photoImageNodes[i].image {
//                    ratio = image.size.height / image.size.width
//                } else if let image = photoImageNodes[i].defaultImage {
//                    ratio = image.size.height / image.size.width
//                }
//                let photoRatio = ASRatioLayoutSpec(ratio: ratio, child: photoImageNodes[i])
//                photoRatio.style.alignSelf = ASStackLayoutAlignSelf.center
//                footerItems.append(photoRatio)
//            }
//            break
//        }
//        let footerStack = ASStackLayoutSpec(direction: .horizontal,
//                                            spacing: 10,
//                                            justifyContent: .center,
//                                            alignItems: .start,
//                                            children: footerItems)
//        footerStack.style.flexShrink = 1
        let verticalStack = ASStackLayoutSpec()
        verticalStack.direction = .vertical
        feedMessageLabel.style.preferredSize = CGSize(width: BBSScreenWidth-VERTICAL_BUFFER*2, height: 40)
        verticalChildren.append(ASInsetLayoutSpec(insets: InsetForHeader, child: headerStack))
        verticalChildren.append(ASInsetLayoutSpec(insets: InsetForFooter, child: footerStack))
        verticalChildren.append(ASInsetLayoutSpec(insets: InsetForFooter, child: feedMessageLabel))
        verticalChildren.append(ASInsetLayoutSpec(insets: InsetForLine, child: lineView))
        
        verticalStack.children = verticalChildren
        
        return verticalStack
    }
    
    // MARK: Instance Methods
    override func didEnterPreloadState() {
        super.didEnterPreloadState()
    }
    
    // MARK: Private Helper
    fileprivate func creatLayerBackedTextNodeWith(attributedString string: NSAttributedString) -> ASTextNode {
        let textNode = ASTextNode()
        textNode.isLayerBacked = true
        textNode.attributedText = string
        return textNode
    }
    
    // MARK: Network Image Delegate
    func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
        setNeedsLayout()
    }
    
    // MARK: Action
    @objc fileprivate func handleClickImgeNode(sender: ASNetworkImageNode) {
        let vc = FeedImageDetailViewController()
        vc.imageDetail.image = sender.image
        RootViewController.navigationController?.pushViewController(vc, animated: true)
    }
}
