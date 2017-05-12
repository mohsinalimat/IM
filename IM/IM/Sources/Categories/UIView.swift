//
//  UIView.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

extension UIView {

    public func im_pinSubview(_ subview: UIView, toEdge attribute: NSLayoutAttribute) {
        
        self.addConstraint(NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: subview, attribute: attribute, multiplier: 1, constant: 0))
    }
    
    public func im_pinAllEdgesOfSubview(_ subview: UIView) {
        
        self.im_pinSubview(subview, toEdge: .bottom)
        self.im_pinSubview(subview, toEdge: .top)
        self.im_pinSubview(subview, toEdge: .leading)
        self.im_pinSubview(subview, toEdge: .trailing)
    }
}
