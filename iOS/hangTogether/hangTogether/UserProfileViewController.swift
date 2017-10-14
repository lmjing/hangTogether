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

        if let profileURL = URL(string: "https://scontent-icn1-1.xx.fbcdn.net/v/t31.0-8/18815155_1337595106348251_8140129323514750362_o.jpg?oh=6be0546d8c1c4399b1076a7bc49d3e75&oe=5A462372") {
            profileImageView.af_setImage(withURL: profileURL)
            profileImageView.drawCircle()
        }
        nicknameLabel.text = user.nickname
        languageLabel.text = user.languages.joined(separator: ",")
        infoLabel.text = "\(user.birth.age) \(user.sex.rawValue)"
        introduceLabel.text = user.introduce
        
        print(user.birth.timeIntervalSinceNow / 60 / 60 / 24 / 365)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
