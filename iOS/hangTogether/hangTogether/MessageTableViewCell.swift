//
//  MessageTableViewCell.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 17..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var newImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.drawCircle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
