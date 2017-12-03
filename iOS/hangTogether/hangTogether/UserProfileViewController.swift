//
//  UserProfileViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 13..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var introduceLabel: UILabel!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.setProfileImage(user: user)
        nicknameLabel.text = user.nickname
        languageLabel.text = user.languages.joined(separator: ",")
        infoLabel.text = "\(user.birth.age) \(user.sex.rawValue)"
        introduceLabel.text = user.introduce
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
