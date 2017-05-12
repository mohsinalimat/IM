//
//  InitalTableViewController.swift
//  SwiftExample
//
//  Created by P D Leonard on 7/22/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import UIKit

let cellIdentifier = "cellIdentifier"

class InitalTableViewController: UITableViewController {
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "IMMessagesViewControler in Swift"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Conversation between two people"
                break
            case 1:
                cell.textLabel?.text = "Group Conversation"
                break
            default:
                break
            }
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Examples"
        default:
            return nil
        }
    }
    
    //Mark: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let chatView = ChatViewController()
                chatView.messages = makeNormalConversation()
                let chatNavigationController = UINavigationController(rootViewController: chatView)
                present(chatNavigationController, animated: true, completion: nil)
            case 1:
                let chatView = ChatViewController()
                chatView.messages = makeGroupConversation()
                let chatNavigationController = UINavigationController(rootViewController: chatView)
                present(chatNavigationController, animated: true, completion: nil)
            default:
                return
            }
        default:
            return
        }
    }
    
    
    
}
