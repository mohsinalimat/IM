//
//  IMSystemSoundPlayer.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import SystemSounds

let kIMMessageReceivedSoundName = "message_received"
let kIMMessageSentSoundName = "message_sent"

extension SystemSounds {
    
    public class func im_playMessageReceivedSound() {
        SystemSounds.im_playSoundFromIMMessagesBundle(name: kIMMessageReceivedSoundName, asAlert: false)
    }
    
    public class func im_playMessageReceivedAlert() {
        SystemSounds.im_playSoundFromIMMessagesBundle(name: kIMMessageReceivedSoundName, asAlert: true)
    }
    
    public class func im_playMessageSentSound() {
        SystemSounds.im_playSoundFromIMMessagesBundle(name: kIMMessageSentSoundName, asAlert: false)
    }
    
    public class func im_playMessageSentAlert() {
        SystemSounds.im_playSoundFromIMMessagesBundle(name: kIMMessageSentSoundName, asAlert: true)
    }
    
    fileprivate class func im_playSoundFromIMMessagesBundle(name: String, asAlert: Bool) {
        // Save sound player original bundle
        let originalPlayerBundleIdentifier = SystemSounds.shared.bundle
        
        if let bundle = Bundle.im_messagesBundle() {
            SystemSounds.shared.bundle = bundle
        }

        let filename = "IMMessagesAssets.bundle/Sounds/\(name)"
        
        SystemSounds.play(sound: filename, withExtension: SystemSounds.Format.aiff.rawValue, bundle: SystemSounds.shared.bundle, isAlert: asAlert, completion: nil)
        
        SystemSounds.shared.bundle = originalPlayerBundleIdentifier
    }
}
