//
//  IMMessagesMediaPlaceholderView.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

class IMMessagesMediaPlaceholderView: UIView {
    
    fileprivate(set) var activityIndicatorView: UIActivityIndicatorView?
    fileprivate(set) var imageView: UIImageView?
    
    // MARK: - Init
    
    class func viewWithActivityIndicator() -> IMMessagesMediaPlaceholderView {
        
        let lightGrayColor = UIColor.im_messageBubbleLightGrayColor()
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
        spinner.color = lightGrayColor
        
        return IMMessagesMediaPlaceholderView(frame: CGRect(x: 0, y: 0, width: 200, height: 120), backgroundColor: lightGrayColor, activityIndicatorView: spinner)
    }
    
    class func viewWithAttachmentIcon() -> IMMessagesMediaPlaceholderView {
        
        let lightGrayColor = UIColor.im_messageBubbleLightGrayColor()
        let paperClip = UIImage.im_defaultAccessoryImage()?.im_imageMaskedWithColor(lightGrayColor.im_colorByDarkeningColorWithValue(0.4))
        let imageView = UIImageView(image: paperClip)
        
        return IMMessagesMediaPlaceholderView(frame: CGRect(x: 0, y: 0, width: 200, height: 120), backgroundColor: lightGrayColor, imageView: imageView)
    }
    
    convenience init(frame: CGRect, backgroundColor: UIColor, activityIndicatorView: UIActivityIndicatorView) {
        
        self.init(frame: frame, backgroundColor: backgroundColor)
        
        self.addSubview(activityIndicatorView)
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.center = self.center
        activityIndicatorView.startAnimating()
        
        self.imageView = nil
    }
    
    convenience init(frame: CGRect, backgroundColor: UIColor, imageView: UIImageView) {
        
        self.init(frame: frame, backgroundColor: backgroundColor)
        
        self.addSubview(imageView)
        self.imageView = imageView
        imageView.center = self.center
        
        self.activityIndicatorView = nil
    }
    
    init(frame: CGRect, backgroundColor: UIColor) {
        
        super.init(frame: frame)
        
        self.backgroundColor = backgroundColor
        self.isUserInteractionEnabled = false
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
    
        super.layoutSubviews()
        
        if let activityIndicatorView = self.activityIndicatorView {
            
            activityIndicatorView.center = self.center
        }
        else if let imageView = self.imageView {
            
            imageView.center = self.center
        }
    }
}
