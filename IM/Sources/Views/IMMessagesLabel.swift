//
//  IMMessagesLabel.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

open class IMMessagesLabel: UILabel {
    
    open var textInsets: UIEdgeInsets = UIEdgeInsets.zero {
        
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    // MARK: - Initialization
    
    func im_configureLabel() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.textInsets = UIEdgeInsets.zero
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.im_configureLabel()
    }

    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.im_configureLabel()
    }
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.im_configureLabel()
    }
    
    // MARK: - Drawing
    
    open override func drawText(in rect: CGRect) {
        
        super.drawText(in: CGRect(x: rect.minX + self.textInsets.left, y: rect.minY + self.textInsets.top, width: rect.width - self.textInsets.right, height: rect.height - self.textInsets.bottom))
    }
}
