//
//  WeiboCellNode.swift
//  HNUSimpleBBS
//
//  Created by 杨扶恺 on 2018/5/19.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

fileprivate let __USER_AVATAR_LENGTH: CGFloat = 30
fileprivate let __FONT_SIZE: CGFloat = 14
fileprivate let HORIZONTAL_BUFFER: CGFloat = 10
fileprivate let VERTICAL_BUFFER: CGFloat = 5
fileprivate let __PHOTO_WIDTH = (BBSScreenWidth-20-40)/3
fileprivate let __PHOTO_HEIGHT: CGFloat = 70
fileprivate let InsetForAvatar = UIEdgeInsetsMake(HORIZONTAL_BUFFER, 0, HORIZONTAL_BUFFER, HORIZONTAL_BUFFER)
fileprivate let InsetForHeader = UIEdgeInsetsMake(0, HORIZONTAL_BUFFER, 0, HORIZONTAL_BUFFER)
fileprivate let InsetForFooter = UIEdgeInsetsMake(VERTICAL_BUFFER, HORIZONTAL_BUFFER, VERTICAL_BUFFER, HORIZONTAL_BUFFER)

class WeiboCellNode: ASCellNode, ASNetworkImageNodeDelegate {
    
    fileprivate var models: WeiboViewModel
    
    fileprivate var userAvatarImageNode: ASNetworkImageNode
    
    fileprivate var photoImageNodes: [ASNetworkImageNode] = []
    
    lazy fileprivate var userNameLabel: ASTextNode = ASTextNode()
    
    lazy fileprivate var feedTimePostLabel: ASTextNode = ASTextNode()
    
    lazy fileprivate var feedMessageLabel: ASTextNode = ASTextNode()
    
    init(weiboViewModel model: WeiboViewModel) {
        models = model
        
        userAvatarImageNode = ASNetworkImageNode()
        userAvatarImageNode.url = URL(string: models.userAvatarUrl)
        userAvatarImageNode.defaultImage = UIImage(named: models.defaultAvatarImg)
        userAvatarImageNode.placeholderEnabled = true
        userAvatarImageNode.placeholderFadeDuration = 1
        userAvatarImageNode.imageModificationBlock = { (image) in
            return image.makeCircularImageWith(size: CGSize(width: __USER_AVATAR_LENGTH, height: __USER_AVATAR_LENGTH))
        }
        
        super.init()
        
        userNameLabel = creatLayerBackedTextNodeWith(attributedString: models.userNameAttributedString(withFontSize: __FONT_SIZE))
        
        feedTimePostLabel = creatLayerBackedTextNodeWith(attributedString: models.timeSincePostAttributedString(withFontSize: __FONT_SIZE))
        
        feedMessageLabel = creatLayerBackedTextNodeWith(attributedString: models.messageAttributedString(withFontSize: __FONT_SIZE))
        feedMessageLabel.maximumNumberOfLines = 4
        
        for url in models.imgUrls {
            let imageNode = ASNetworkImageNode()
            imageNode.delegate = self
            imageNode.url = URL(string: url)
            imageNode.isLayerBacked = true
            imageNode.defaultImage = UIImage(named: models.dafaultImgPath)
            imageNode.placeholderEnabled = true
            imageNode.placeholderFadeDuration = 1
            photoImageNodes.append(imageNode)
        }
        
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
        userInfoStack.style.flexShrink = 1
        headerChildren.append(userInfoStack)
        
        userNameLabel.style.flexShrink = 1
        userInfoStack.children = [userNameLabel]
        
        feedTimePostLabel.style.flexShrink = 1
        userInfoStack.children?.append(feedTimePostLabel)
        
        headerStack.children = headerChildren
        
        var footerItems: Array<ASLayoutElement> = []
        for i in 0..<photoImageNodes.count {
            photoImageNodes[i].style.preferredSize = CGSize(width: __PHOTO_WIDTH, height: __PHOTO_HEIGHT)
            if i < 3 {
                var ratio: CGFloat = 1
                
                if let image = photoImageNodes[i].image {
                    ratio = image.size.height / image.size.width
                } else if let image = photoImageNodes[i].defaultImage {
                    ratio = image.size.height / image.size.width
                }
                let photoRatio = ASRatioLayoutSpec(ratio: ratio, child: photoImageNodes[i])
                photoRatio.style.alignSelf = ASStackLayoutAlignSelf.center
                footerItems.append(photoRatio)
            }
            break
        }
        let footerStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 10,
                                            justifyContent: .center,
                                            alignItems: .start,
                                            children: footerItems)
        footerStack.style.flexShrink = 1
        let verticalStack = ASStackLayoutSpec()
        verticalStack.direction = .vertical
        verticalChildren.append(ASInsetLayoutSpec(insets: InsetForHeader, child: headerStack))
        verticalChildren.append(ASInsetLayoutSpec(insets: InsetForFooter, child: footerStack))
        
        verticalStack.children = verticalChildren
        
        return verticalStack
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
}
