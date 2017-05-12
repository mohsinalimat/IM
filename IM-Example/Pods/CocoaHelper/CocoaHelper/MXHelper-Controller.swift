//
//  MXHelper-Controller.swift
//  Pods
//
//  Created by Meniny on 2017-05-07.
//
//

import Foundation

#if os(iOS)
    import UIKit
    
    public extension UIViewController {
        
        public func share(items: [Any], barButtonItem: UIBarButtonItem?, completion: UIActivityViewControllerCompletionWithItemsHandler?) {
            let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
            activityController.popoverPresentationController?.barButtonItem = barButtonItem
            activityController.completionWithItemsHandler = completion
            self.present(activityController, animated: true, completion: nil)
        }
        
        public func share(items: [Any], sourceView: UIView?, sourceRect: CGRect?, completion: UIActivityViewControllerCompletionWithItemsHandler?) {
            let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = sourceView
            if let rect = sourceRect {
                activityController.popoverPresentationController?.sourceRect = rect
            }
            activityController.completionWithItemsHandler = completion
            self.present(activityController, animated: true, completion: nil)
        }
    }
#endif
