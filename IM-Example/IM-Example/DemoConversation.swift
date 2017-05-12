//
//  DemoConversation.swift
//  SwiftExample
//
//  Created by Meniny on 5/11/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import IM

// User Enum to make it easyier to work with.
enum User: String {
    case Leonard    = "053496-4509-288"
    case Squires    = "053496-4509-289"
    case Jobs       = "707-8956784-57"
    case Cook       = "468-768355-23123"
    case Wozniak    = "309-41802-93823"
}

// Helper Function to get usernames for a secific User.
func getName(_ user: User) -> String{
    switch user {
    case .Squires:
        return "Jesse Squires"
    case .Cook:
        return "Tim Cook"
    case .Wozniak:
        return "Steve Wozniak"
    case .Leonard:
        return "Meniny"
    case .Jobs:
        return "Steve Jobs"
    }
}
//// Create Names to display
//public let DisplayNameSquires = "Jesse Squires"
//public let DisplayNameLeonard = "Meniny"
//public let DisplayNameCook = "Tim Cook"
//public let DisplayNameJobs = "Steve Jobs"
//public let DisplayNameWoz = "Steve Wazniak"



// Create Unique IDs for avatars
public let AvatarIDLeonard = "053496-4509-288"
public let AvatarIDSquires = "053496-4509-289"
public let AvatarIdCook = "468-768355-23123"
public let AvatarIdJobs = "707-8956784-57"
public let AvatarIdWoz = "309-41802-93823"

// Create Avatars Once for performance
//
// Create an avatar with Image

public let AvatarLeonard = IMMessagesAvatarImageFactory.avatarImage(userInitials: "DL", backgroundColor: UIColor.im_messageBubbleGreenColor(), textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12), diameter: 50)

public let AvatarCook = IMMessagesAvatarImageFactory.avatarImage(userInitials: "TC", backgroundColor: UIColor.gray, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12), diameter: 50)

// Create avatar with Placeholder Image
public let AvatarJobs = IMMessagesAvatarImageFactory.avatarImage(placholder: UIImage(named:"demo_avatar_jobs")!, diameter: 50)

public let AvatarWoz = IMMessagesAvatarImageFactory.avatarImage(userInitials: "SW", backgroundColor: UIColor.im_messageBubbleGreenColor(), textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12), diameter: 50)

public let AvatarSquires = IMMessagesAvatarImageFactory.avatarImage(userInitials: "IM", backgroundColor: UIColor.gray, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12), diameter: 50)

// Helper Method for getting an avatar for a specific User.
public func getAvatar(_ id: String) -> IMMessagesAvatarImage{
    let user = User(rawValue: id)!
    
    switch user {
    case .Leonard:
        return AvatarLeonard
    case .Squires:
        return AvatarSquires
    case .Cook:
        return AvatarCook
    case .Wozniak:
        return AvatarWoz
    case .Jobs:
        return AvatarJobs
    }
}



// INFO: Creating Static Demo Data. This is only for the exsample project to show the framework at work.
var conversationsList = [Conversation]()

var convo = Conversation(firstName: "Steave", lastName: "Jobs", preferredName:  "Stevie", smsNumber: "(987)987-9879", id: "33", latestMessage: "Holy Guacamole, IM in swift", isRead: false)

var conversation = [IMMessage]()

public let message = IMMessage(senderId: AvatarIdCook, senderDisplayName: getName(User.Cook), text: "What is this Black Majic?")
public let message2 = IMMessage(senderId: AvatarIDSquires, senderDisplayName: getName(User.Squires), text: "It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy")
public let message3 = IMMessage(senderId: AvatarIdWoz, senderDisplayName: getName(User.Wozniak), text: "It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com.")
public let message4 = IMMessage(senderId: AvatarIdJobs, senderDisplayName: getName(User.Jobs), text: "IMMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better.")
public let message5 = IMMessage(senderId: AvatarIDLeonard, senderDisplayName: getName(User.Leonard), text: "It is unit-tested, free, open-source, and documented.")


public let message6 = IMMessage(senderId: AvatarIDLeonard, senderDisplayName: getName(User.Leonard), text: "This is incredible")
public let message7 = IMMessage(senderId: AvatarIdWoz, senderDisplayName: getName(User.Wozniak), text: "I would have to agree")
public let message8 = IMMessage(senderId: AvatarIDLeonard, senderDisplayName: getName(User.Leonard), text: "It is unit-tested, free, open-source, and documented like a boss.")
public let message9 = IMMessage(senderId: AvatarIdWoz, senderDisplayName: getName(User.Wozniak), text: "You guys need an award for this, I'll talk to my people at Apple. 💯 💯 💯")

// photo message
public let photoItem = IMPhotoMediaItem(image: UIImage(named: "goldengate"))
public let photoMessage = IMMessage(senderId: AvatarIdWoz, senderDisplayName: getName(User.Wozniak), media: photoItem)

// audio mesage
//public let sample = Bundle.main.path(forResource: "im_messages_sample", ofType: "m4a")
//public let audioData = try? Data(contentsOf: URL(fileURLWithPath: sample!))
//public let audioItem = IMAudioMediaItem(data: audioData)
//public let audioMessage = IMMessage(senderId: AvatarIdWoz, displayName: getName(User.Wozniak), media: audioItem)

func makeGroupConversation()->[IMMessage] {
    conversation = [message, message2,message3, message4, message5, photoMessage]//, audioMessage]
    return conversation
}

func makeNormalConversation() -> [IMMessage] {
    conversation = [message6, message7, message8, message9, photoMessage]//, audioMessage]
    return conversation
}
