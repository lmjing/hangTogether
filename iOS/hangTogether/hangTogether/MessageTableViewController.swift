//
//  MessageTableViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 17..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit
import AlamofireImage

class MessageTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageTableViewCell
        
        cell.messageLabel.text = "긴 텍스트지로오오옹"
        cell.nicknameLabel.text = "mizzo"
        cell.profileImageView.setProfileImage(user: User())
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
}
