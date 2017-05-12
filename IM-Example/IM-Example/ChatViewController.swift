//
//  ChatViewController.swift
//  SwiftExample
//
//  Created by Meniny on 5/11/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import UIKit
import IM
import CoreLocation

class ChatViewController: IMMessagesViewController {
    var messages = [IMMessage]()
    let defaults = UserDefaults.standard
    var conversation: Conversation?
    var incomingBubble: IMMessagesBubbleImage!
    var outgoingBubble: IMMessagesBubbleImage!
    fileprivate var displayName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation
        setupBackButton()
        
        /**
         *  Override point:
         *
         *  Example of how to cusomize the bubble appearence for incoming and outgoing messages.
         *  Based on the Settings of the user display two differnent type of bubbles.
         *
         */
        
//        if defaults.bool(forKey: Setting.removeBubbleTails.rawValue) {
//            // Make taillessBubbles
//            //, layoutDirection: UIApplication.shared.userInterfaceLayoutDirection
//            incomingBubble = IMMessagesBubbleImageFactory(bubbleImage: UIImage.im_bubbleCompactTaillessImage()!, capInsets: UIEdgeInsets.zero).incomingMessagesBubbleImage(color: UIColor.im_messageBubbleBlueColor())
//            outgoingBubble = IMMessagesBubbleImageFactory(bubbleImage: UIImage.im_bubbleCompactTaillessImage()!, capInsets: UIEdgeInsets.zero).outgoingMessagesBubbleImage(color: UIColor.lightGray)
//        }
//        else {
            // Bubbles with tails
            incomingBubble = IMMessagesBubbleImageFactory().incomingMessagesBubbleImage(color: UIColor.im_messageBubbleBlueColor())
            outgoingBubble = IMMessagesBubbleImageFactory().outgoingMessagesBubbleImage(color: UIColor.lightGray)
//        }
        
        /**
         *  Example on showing or removing Avatars based on user settings.
         */
        
//        if defaults.bool(forKey: Setting.removeAvatar.rawValue) {
//            collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
//            collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
//        } else {
//            collectionView?.collectionViewLayout.incomingAvatarViewSize = CGSize(width: kIMMessagesCollectionViewAvatarSizeDefault, height:kIMMessagesCollectionViewAvatarSizeDefault )
//            collectionView?.collectionViewLayout.outgoingAvatarViewSize = CGSize(width: kIMMessagesCollectionViewAvatarSizeDefault, height:kIMMessagesCollectionViewAvatarSizeDefault )
//        }
        
        // Show Button to simulate incoming messages
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.im_defaultTypingIndicatorImage(), style: .plain, target: self, action: #selector(receiveMessagePressed))
        
        // This is a beta feature that mostly works but to make things more stable it is diabled.
//        collectionView?.collectionViewLayout.springinessEnabled = false
        
        automaticallyScrollsToMostRecentMessage = true

        self.collectionView?.reloadData()
        self.collectionView?.layoutIfNeeded()
    }
    
    func setupBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func receiveMessagePressed(_ sender: UIBarButtonItem) {
        /**
         *  DEMO ONLY
         *
         *  The following is simply to simulate received messages for the demo.
         *  Do not actually do this.
         */
        
        /**
         *  Show the typing indicator to be shown
         */
        self.showTypingIndicator = !self.showTypingIndicator
        
        /**
         *  Scroll to actually view the indicator
         */
        self.scrollToBottom(animated: true)
        
        /**
         *  Copy last sent message, this will be the new "received" message
         */
        var copyMessage = self.messages.last?.copy()
        
        if (copyMessage == nil) {
            copyMessage = IMMessage(senderId: AvatarIdJobs, senderDisplayName: getName(User.Jobs), text: "First received!")
        }
            
        var newMessage:IMMessage!
        var newMediaData:IMMessageMediaData!
        var newMediaAttachmentCopy:AnyObject?
        
        if (copyMessage! as AnyObject).isMediaMessage {
            /**
             *  Last message was a media message
             */
            let copyMediaData = (copyMessage! as AnyObject).media
            
            switch copyMediaData {
            case is IMPhotoMediaItem:
                let photoItemCopy = (copyMediaData as! IMPhotoMediaItem).copy() as! IMPhotoMediaItem
                photoItemCopy.appliesMediaViewMaskAsOutgoing = false
                if let ci = photoItemCopy.image?.cgImage {
                    newMediaAttachmentCopy = UIImage(cgImage: ci)
                } else {
                    newMediaAttachmentCopy = photoItemCopy.image
                }
                
                /**
                 *  Set image to nil to simulate "downloading" the image
                 *  and show the placeholder view5017
                 */
                photoItemCopy.image = nil;
                
                newMediaData = photoItemCopy
            case is IMLocationMediaItem:
                let locationItemCopy = (copyMediaData as! IMLocationMediaItem).copy() as! IMLocationMediaItem
                locationItemCopy.appliesMediaViewMaskAsOutgoing = false
                if let loc = locationItemCopy.location {
                    newMediaAttachmentCopy = loc.copy() as AnyObject?
                } else {
                    newMediaAttachmentCopy = locationItemCopy.location
                }
                
                /**
                 *  Set location to nil to simulate "downloading" the location data
                 */
                locationItemCopy.location = nil;
                
                newMediaData = locationItemCopy;
            case is IMVideoMediaItem:
                let videoItemCopy = (copyMediaData as! IMVideoMediaItem).copy() as! IMVideoMediaItem
                videoItemCopy.appliesMediaViewMaskAsOutgoing = false
                if let u = videoItemCopy.fileURL {
                    newMediaAttachmentCopy = (u as NSURL).copy() as AnyObject?
                } else {
                    newMediaAttachmentCopy = videoItemCopy.fileURL as AnyObject
                }
                
                /**
                 *  Reset video item to simulate "downloading" the video
                 */
                videoItemCopy.fileURL = nil;
                videoItemCopy.isReadyToPlay = false;
                
                newMediaData = videoItemCopy;
//            case is IMAudioMediaItem:
//                let audioItemCopy = (copyMediaData as! IMAudioMediaItem).copy() as! IMAudioMediaItem
//                audioItemCopy.appliesMediaViewMaskAsOutgoing = false
//                newMediaAttachmentCopy = (audioItemCopy.audioData! as NSData).copy() as AnyObject?
//                
//                /**
//                 *  Reset audio item to simulate "downloading" the audio
//                 */
//                audioItemCopy.audioData = nil;
//                
//                newMediaData = audioItemCopy;
            default:
                assertionFailure("Error: This Media type was not recognised")
            }
            
            newMessage = IMMessage(senderId: AvatarIdJobs, senderDisplayName: getName(User.Jobs), media: newMediaData)
        }
        else {
            /**
             *  Last message was a text message
             */
            
            newMessage = IMMessage(senderId: AvatarIdJobs, senderDisplayName: getName(User.Jobs), text: (copyMessage! as AnyObject).text)
        }
        
        /**
         *  Upon receiving a message, you should:
         *
         *  1. Play sound (optional)
         *  2. Add new IMMessageData object to your data source
         *  3. Call `finishReceivingMessage`
         */
        
        self.messages.append(newMessage)
        self.finishReceivingMessage(animated: true)
        
        if newMessage.isMediaMessage {
            /**
             *  Simulate "downloading" media
             */
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                /**
                 *  Media is "finished downloading", re-display visible cells
                 *
                 *  If media cell is not visible, the next time it is dequeued the view controller will display its new attachment data
                 *
                 *  Reload the specific item, or simply call `reloadData`
                 */
                
                switch newMediaData {
                case is IMPhotoMediaItem:
                    (newMediaData as! IMPhotoMediaItem).image = newMediaAttachmentCopy as? UIImage
                    self.collectionView!.reloadData()
                case is IMLocationMediaItem:
                    (newMediaData as! IMLocationMediaItem).set(newMediaAttachmentCopy as? CLLocation, completion: {
                        self.collectionView!.reloadData()
                    })
                case is IMVideoMediaItem:
                    (newMediaData as! IMVideoMediaItem).fileURL = newMediaAttachmentCopy as? URL
                    (newMediaData as! IMVideoMediaItem).isReadyToPlay = true
                    self.collectionView!.reloadData()
//                case is IMAudioMediaItem:
//                    (newMediaData as! IMAudioMediaItem).audioData = newMediaAttachmentCopy as? Data
//                    self.collectionView!.reloadData()
                default:
                    assertionFailure("Error: This Media type was not recognised")
                }
            }
        }
    }
    
    // MARK: IMMessagesViewController method overrides
    override func didPressSendButton(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        /**
         *  Sending a message. Your implementation of this method should do *at least* the following:
         *
         *  1. Play sound (optional)
         *  2. Add new id<IMMessageData> object to your data source
         *  3. Call `finishSendingMessage`
         */
        
        let message = IMMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(message)
        self.finishSendingMessage(animated: true)
    }
    
    override func didPressAccessoryButton(_ sender: UIButton) {
        self.inputToolbar.contentView!.textView!.resignFirstResponder()
        
        let sheet = UIAlertController(title: "Media messages", message: nil, preferredStyle: .actionSheet)
        
        let photoAction = UIAlertAction(title: "Send photo", style: .default) { (action) in
            /**
             *  Create fake photo
             */
            let photoItem = IMPhotoMediaItem(image: UIImage(named: "goldengate"))
            self.addMedia(photoItem)
        }
        
        let locationAction = UIAlertAction(title: "Send location", style: .default) { (action) in
            /**
             *  Add fake location
             */
            let locationItem = self.buildLocationItem()
            
            self.addMedia(locationItem)
        }
        
        let videoAction = UIAlertAction(title: "Send video", style: .default) { (action) in
            /**
             *  Add fake video
             */
            let videoItem = self.buildVideoItem()
            
            self.addMedia(videoItem)
        }
        
//        let audioAction = UIAlertAction(title: "Send audio", style: .default) { (action) in
//            /**
//             *  Add fake audio
//             */
//            let audioItem = self.buildAudioItem()
//            
//            self.addMedia(audioItem)
//        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        sheet.addAction(photoAction)
        sheet.addAction(locationAction)
        sheet.addAction(videoAction)
//        sheet.addAction(audioAction)
        sheet.addAction(cancelAction)
        
        self.present(sheet, animated: true, completion: nil)
    }
    
    func buildVideoItem() -> IMVideoMediaItem {
        let videoURL = URL(fileURLWithPath: "file://")
        
        let videoItem = IMVideoMediaItem(fileURL: videoURL, isReadyToPlay: true)
        
        return videoItem
    }
    
//    func buildAudioItem() -> IMAudioMediaItem {
//        let sample = Bundle.main.path(forResource: "im_messages_sample", ofType: "m4a")
//        let audioData = try? Data(contentsOf: URL(fileURLWithPath: sample!))
//        
//        let audioItem = IMAudioMediaItem(data: audioData)
//        
//        return audioItem
//    }
    
    func buildLocationItem() -> IMLocationMediaItem {
        let ferryBuildingInSF = CLLocation(latitude: 37.795313, longitude: -122.393757)
        
        let locationItem = IMLocationMediaItem()
        locationItem.set(ferryBuildingInSF, completion: {
            self.collectionView!.reloadData()
        })
        
        return locationItem
    }
    
    func addMedia(_ media:IMMediaItem) {
        let message = IMMessage(senderId: self.senderID, senderDisplayName: self.senderDisplayName, media: media)
        self.messages.append(message)
        
        //Optional: play sent sound
        
        self.finishSendingMessage(animated: true)
    }
    
    
    //MARK: IMMessages CollectionView DataSource
    override var senderID: String {
        set {
            
        }
        get {
            return User.Wozniak.rawValue
        }
    }
    override var senderDisplayName: String {
        set {
            
        }
        get {
            return getName(.Wozniak)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: IMMessagesCollectionView, messageDataForItemAtIndexPath indexPath: IndexPath) -> IMMessageData {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: IMMessagesCollectionView, messageBubbleImageDataForItemAtIndexPath indexPath: IndexPath) -> IMMessageBubbleImageDataSource {
        
        return messages[indexPath.item].senderID == self.senderID ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: IMMessagesCollectionView, avatarImageDataForItemAtIndexPath indexPath: IndexPath) -> IMMessageAvatarImageDataSource? {
        let message = messages[indexPath.item]
        return getAvatar(message.senderID)
    }
    
    override func collectionView(_ collectionView: IMMessagesCollectionView, attributedTextForCellTopLabelAtIndexPath indexPath: IndexPath) -> NSAttributedString? {
        /**
         *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
         *  The other label text delegate methods should follow a similar pattern.
         *
         *  Show a timestamp for every 3rd message
         */
        if (indexPath.item % 3 == 0) {
            let message = self.messages[indexPath.item]
            return IMMessagesTimestampFormatter.sharedFormatter.attributedTimestamp(message.date)
        }
        
        return nil
    }
    
    override func collectionView(_ collectionView: IMMessagesCollectionView, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: IndexPath) -> NSAttributedString? {
        
        let message = messages[indexPath.item]
        
        // Displaying names above messages
        //Mark: Removing Sender Display Name
        /**
         *  Example on showing or removing senderDisplayName based on user settings.
         *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
         */
//        if defaults.bool(forKey: Setting.removeSenderDisplayName.rawValue) {
//            return nil
//        }
        
        if message.senderID == self.senderID {
            return nil
        }

        return NSAttributedString(string: message.senderDisplayName)
    }
    
    override func collectionView(_ collectionView: IMMessagesCollectionView, layout collectionViewLayout: IMMessagesCollectionViewFlowLayout, heightForCellTopLabelAtIndexPath indexPath: IndexPath) -> CGFloat {
        /**
         *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
         */
        
        /**
         *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
         *  The other label height delegate methods should follow similarly
         *
         *  Show a timestamp for every 3rd message
         */
        if indexPath.item % 3 == 0 {
            return kIMMessagesCollectionViewCellLabelHeightDefault
        }
        
        return 0.0
    }

    override func collectionView(_ collectionView: IMMessagesCollectionView, layout: IMMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        /**
         *  Example on showing or removing senderDisplayName based on user settings.
         *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
         */
//        if defaults.bool(forKey: Setting.removeSenderDisplayName.rawValue) {
//            return 0.0
//        }
        
        /**
         *  iOS7-style sender name labels
         */
        let currentMessage = self.messages[indexPath.item]
        
        if currentMessage.senderID == self.senderID {
            return 0.0
        }
        
        if indexPath.item - 1 > 0 {
            let previousMessage = self.messages[indexPath.item - 1]
            if previousMessage.senderID == currentMessage.senderID {
                return 0.0
            }
        }
        
        return kIMMessagesCollectionViewCellLabelHeightDefault;
    }
    
}
