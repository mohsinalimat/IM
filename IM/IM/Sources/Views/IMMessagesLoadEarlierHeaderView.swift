//
//  IMMessagesLoadEarlierHeaderView.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

public protocol IMMessagesLoadEarlierHeaderViewDelegate {
    
    func headerView(_ headerView: IMMessagesLoadEarlierHeaderView, didPressLoadButton sender: UIButton?)
}

open class IMMessagesLoadEarlierHeaderView: UICollectionReusableView {
    
    static var kIMMessagesLoadEarlierHeaderViewHeight: CGFloat = 32
    var delegate: IMMessagesLoadEarlierHeaderViewDelegate?
    
    @IBOutlet var loadButton: UIButton!
    
    open class func nib() -> UINib {
        
        return UINib(nibName: "\(IMMessagesLoadEarlierHeaderView.self)".im_className(), bundle: Bundle(for: IMMessagesLoadEarlierHeaderView.self))
    }
    
    open class func headerReuseIdentifier() -> String {
        
        return "\(IMMessagesLoadEarlierHeaderView.self)".im_className()
    }
    
    // MARK: - Initialization
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.clear
        
        self.loadButton.setTitle(Bundle.im_localizedStringForKey("load_earlier_messages"), for: UIControlState())
        self.loadButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
    }
    
    // MARK: - Reusable view
    
    open override var backgroundColor: UIColor? {
        
        didSet {
            
            self.loadButton.backgroundColor = backgroundColor
        }
    }
    
    // MARK: - Actions
    
    @IBAction func loadButtonPressed(_ sender: UIButton) {
        
        self.delegate?.headerView(self, didPressLoadButton: sender)
    }
}

