//
//  UIImage.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

extension UIImage {
    
    public func im_imageMaskedWithColor(_ maskColor: UIColor) -> UIImage {
        
        let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -imageRect.height)
        
        context?.clip(to: imageRect, mask: self.cgImage!)
        context?.setFillColor(maskColor.cgColor)
        context?.fill(imageRect)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {

            UIGraphicsEndImageContext()
            return image
        }

        UIGraphicsEndImageContext()
        return self
    }
    
    public class func im_bubbleImageFromBundle(name: String) -> UIImage? {
        
        if let bundle = Bundle.im_messagesAssetBundle(),
            let path = bundle.path(forResource: name, ofType: "png", inDirectory: "Images") {
        
            return UIImage(contentsOfFile: path)
        }
        
        return nil
    }
    
    public class func im_bubbleRegularImage() -> UIImage? {

        return UIImage.im_bubbleImageFromBundle(name: "bubble_regular")
    }
    
    public class func im_bubbleRegularTaillessImage() -> UIImage? {
        
        return UIImage.im_bubbleImageFromBundle(name: "bubble_tailless")
    }
    
    public class func im_bubbleRegularStrokedImage() -> UIImage? {
        
        return UIImage.im_bubbleImageFromBundle(name: "bubble_stroked")
    }
    
    public class func im_bubbleRegularStrokedTaillessImage() -> UIImage? {
        
        return UIImage.im_bubbleImageFromBundle(name: "bubble_stroked_tailless")
    }
    
    public class func im_bubbleCompactImage() -> UIImage? {
        
        return UIImage.im_bubbleImageFromBundle(name: "bubble_min")
    }
    
    public class func im_bubbleCompactTaillessImage() -> UIImage? {
        
        return UIImage.im_bubbleImageFromBundle(name: "bubble_min_tailless")
    }
    
    public class func im_defaultAccessoryImage() -> UIImage? {
        
        return UIImage.im_bubbleImageFromBundle(name: "clip")
    }
    
    public class func im_defaultTypingIndicatorImage() -> UIImage? {
        
        return UIImage.im_bubbleImageFromBundle(name: "typing")
    }
    
    public class func im_defaultPlayImage() -> UIImage? {
        
        return UIImage.im_bubbleImageFromBundle(name: "play")
    }
}
