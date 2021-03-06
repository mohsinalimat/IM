//
//  IMMessagesMediaViewBubbleImageMasker.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation
import UIKit

open class IMMessagesMediaViewBubbleImageMasker {
    
    fileprivate(set) var bubbleImageFactory: IMMessagesBubbleImageFactory
    
    public convenience init() {
        
        self.init(bubbleImageFactory: IMMessagesBubbleImageFactory())
    }
    
    public init(bubbleImageFactory: IMMessagesBubbleImageFactory) {
        
        self.bubbleImageFactory = bubbleImageFactory
    }
    
    // MARK: - View masking
    
    open func applyOutgoingBubbleImageMask(mediaView: UIView) {
        
        let bubbleImageData = self.bubbleImageFactory.outgoingMessagesBubbleImage(color: UIColor.white)
        self.im_maskView(mediaView, image: bubbleImageData.messageBubbleImage)
    }
    
    open func applyIncomingBubbleImageMask(mediaView: UIView) {
        
        let bubbleImageData = self.bubbleImageFactory.incomingMessagesBubbleImage(color: UIColor.white)
        self.im_maskView(mediaView, image: bubbleImageData.messageBubbleImage)
    }
    
    open class func applyBubbleImageMaskToMediaView(_ mediaView: UIView, isOutgoing: Bool) {
        
        let masker = IMMessagesMediaViewBubbleImageMasker()
        
        if isOutgoing {
            masker.applyOutgoingBubbleImageMask(mediaView: mediaView)
        }
        else {
            masker.applyIncomingBubbleImageMask(mediaView: mediaView)
        }
    }
    
    // MARK: - Private
    
    fileprivate func im_maskView(_ view: UIView, image: UIImage) {
        
        let imageViewMask = UIImageView(image: image)
        imageViewMask.frame = view.frame.insetBy(dx: 2, dy: 2)
        
        view.layer.mask = imageViewMask.layer
    }
}
