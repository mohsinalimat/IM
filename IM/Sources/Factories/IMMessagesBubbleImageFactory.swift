//
//  IMMessagesBubbleImageFactory.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation
import UIKit

open class IMMessagesBubbleImageFactory {
    
    fileprivate let bubbleImage: UIImage
    fileprivate var capInsets: UIEdgeInsets
    
    public convenience init() {
        
        self.init(bubbleImage: UIImage.im_bubbleCompactImage()!, capInsets: UIEdgeInsets.zero)
    }
    
    public init(bubbleImage: UIImage, capInsets: UIEdgeInsets) {
    
        self.bubbleImage = bubbleImage
        self.capInsets = capInsets
        
        if UIEdgeInsetsEqualToEdgeInsets(capInsets, UIEdgeInsets.zero) {
            
            self.capInsets = self.im_centerPointEdgeInsetsForImageSize(bubbleImage.size)
        }
        else {
            
            self.capInsets = capInsets
        }
    }
    
    // MARK: - Public
    
    open func outgoingMessagesBubbleImage(color: UIColor) -> IMMessagesBubbleImage {

        return self.im_messagesBubbleImage(color: color, flippedForIncoming: false)
    }
    
    open func incomingMessagesBubbleImage(color: UIColor) -> IMMessagesBubbleImage {
        
        return self.im_messagesBubbleImage(color: color, flippedForIncoming: true)
    }
    
    // MARK: - Private
    
    func im_centerPointEdgeInsetsForImageSize(_ bubbleImageSize: CGSize) -> UIEdgeInsets {
        
        let center = CGPoint(x: bubbleImageSize.width/2, y: bubbleImageSize.height/2)
        return UIEdgeInsetsMake(center.y, center.x, center.y, center.x)
    }
    
    func im_messagesBubbleImage(color: UIColor, flippedForIncoming: Bool) -> IMMessagesBubbleImage {
        
        var normalBubble = self.bubbleImage.im_imageMaskedWithColor(color)
        var highlightedBubble = self.bubbleImage.im_imageMaskedWithColor(color.im_colorByDarkeningColorWithValue(0.12))
        
        if flippedForIncoming {
            
            normalBubble = self.im_horizontallyFlippedImage(normalBubble)
            highlightedBubble = self.im_horizontallyFlippedImage(highlightedBubble)
        }
        
        normalBubble = self.im_stretchableImage(normalBubble, capInsets: self.capInsets)
        highlightedBubble = self.im_stretchableImage(highlightedBubble, capInsets: self.capInsets)
        
        return IMMessagesBubbleImage(bubbleImage: normalBubble, highlightedImage: highlightedBubble)
    }
    
    func im_horizontallyFlippedImage(_ image: UIImage) -> UIImage {
        
        if let cgImage = image.cgImage {
            
            return UIImage(cgImage: cgImage, scale: image.scale, orientation: .upMirrored)
        }
        
        return image
    }
    
    func im_stretchableImage(_ image: UIImage, capInsets: UIEdgeInsets) -> UIImage {
        
        return image.resizableImage(withCapInsets: capInsets, resizingMode: .stretch)
    }
}
