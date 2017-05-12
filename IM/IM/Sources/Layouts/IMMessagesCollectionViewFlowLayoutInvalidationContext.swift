//
//  IMMessagesCollectionViewFlowLayoutInvalidationContext.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

class IMMessagesCollectionViewFlowLayoutInvalidationContext: UICollectionViewFlowLayoutInvalidationContext {
    
    var invalidateFlowLayoutMessagesCache: Bool = false
    
    override init() {
        
        super.init()
        
        self.invalidateFlowLayoutDelegateMetrics = false
        self.invalidateFlowLayoutAttributes = false
        self.invalidateFlowLayoutMessagesCache = false
    }
    
    class func context() -> IMMessagesCollectionViewFlowLayoutInvalidationContext {
        
        let context = IMMessagesCollectionViewFlowLayoutInvalidationContext()
        context.invalidateFlowLayoutDelegateMetrics = true
        context.invalidateFlowLayoutAttributes = true
        return context
    }
    
    // MARK: - NSObject
    
    override var description: String {
        
        get {
            
            return "<\(type(of: self)): invalidateFlowLayoutDelegateMetrics=\(self.invalidateFlowLayoutDelegateMetrics), invalidateFlowLayoutAttributes=\(self.invalidateFlowLayoutAttributes), invalidateDataSourceCounts=\(self.invalidateDataSourceCounts), invalidateFlowLayoutMessagesCache=\(self.invalidateFlowLayoutMessagesCache)>"
        }
    }
}
