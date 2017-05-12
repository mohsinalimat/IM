//
//  MXHelper-Notification.swift
//  Pods
//
//  Created by Meniny on 2017-05-03.
//
//

import Foundation

#if os(OSX)
    import Cocoa
#else
    import Foundation
    import UIKit
#endif

#if os(iOS)
#else
    /// Notify at NotificationCenter
    ///
    /// - Parameters:
    ///   - title: title string
    ///   - informative: optional message string
    ///   - image: optional image object
    ///   - sound: optional sound name string
    ///   - delegate: NSUserNotificationCenterDelegate
    public func notify(title: String, informative: String? = nil, image: NSImage? = nil, sound: String? = NSUserNotificationDefaultSoundName, delegate: NSUserNotificationCenterDelegate? = nil) {
        
        let notification = NSUserNotification()
        let notificationCenter = NSUserNotificationCenter.default
        notificationCenter.delegate = delegate
        notification.title = title
        notification.informativeText = informative
        notification.contentImage = image
        notification.soundName = sound;
        notificationCenter.scheduleNotification(notification)
    }
#endif
