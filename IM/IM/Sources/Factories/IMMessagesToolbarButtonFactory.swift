//
//  IMMessagesToolbarButtonFactory.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation

open class IMMessagesToolbarButtonFactory {
    
    open class func defaultAccessoryButtonItem() -> UIButton {
    
        let accessoryImage = UIImage.im_defaultAccessoryImage()!
        let normalImage = accessoryImage.im_imageMaskedWithColor(UIColor.lightGray)
        let highlightedImage = accessoryImage.im_imageMaskedWithColor(UIColor.darkGray)
        
        let accessoryButton = UIButton(frame: CGRect(x: 0, y: 0, width: accessoryImage.size.width, height: 32))
        accessoryButton.setImage(normalImage, for: UIControlState())
        accessoryButton.setImage(highlightedImage, for: .highlighted)
        
        accessoryButton.contentMode = .scaleAspectFit
        accessoryButton.backgroundColor = UIColor.clear
        accessoryButton.tintColor = UIColor.lightGray
        
        return accessoryButton
    }
    
    open class func defaultSendButtonItem() -> UIButton {
    
        let sendTitle = Bundle.im_localizedStringForKey("send")
        
        let sendButton = UIButton(frame: CGRect.zero)
        sendButton.setTitle(sendTitle, for: UIControlState())
        sendButton.setTitleColor(UIColor.im_messageBubbleBlueColor(), for: UIControlState())
        sendButton.setTitleColor(UIColor.im_messageBubbleBlueColor().im_colorByDarkeningColorWithValue(0.1), for: .highlighted)
        sendButton.setTitleColor(UIColor.lightGray, for: .disabled)
        
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        sendButton.titleLabel?.adjustsFontSizeToFitWidth = true
        sendButton.titleLabel?.minimumScaleFactor = 0.85
        sendButton.contentMode = .center
        sendButton.backgroundColor = UIColor.clear
        sendButton.tintColor = UIColor.im_messageBubbleBlueColor()
        
        let maxHeight: CGFloat = 32
        let options: NSStringDrawingOptions = [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading]
        let attributes: [String : AnyObject] = sendButton.titleLabel?.font != nil ? [ NSFontAttributeName: sendButton.titleLabel!.font!] : [:]
        
        let sendTitleRect = (sendTitle as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: maxHeight), options: options, attributes: attributes, context: nil)

        sendButton.frame = CGRect(x: 0, y: 0, width: sendTitleRect.integral.width, height: maxHeight)

        return sendButton
    }
}
