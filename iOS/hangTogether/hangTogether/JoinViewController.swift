//
//  JoinViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 18..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailTextField: paddingTextField!
    @IBOutlet weak var emailCheckButton: UIButton!
    @IBOutlet weak var nicknameTextField: paddingTextField!
    @IBOutlet weak var nicknameCheckButton: UIButton!
    @IBOutlet weak var passwordTextField: paddingTextField!
    @IBOutlet weak var passwordCheckTextField: paddingTextField!
    @IBOutlet weak var birthTextField: paddingTextField!
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cancleButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        let joinButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(joinUser))
        
        navigationItem.leftBarButtonItem = cancleButton
        navigationItem.rightBarButtonItem = joinButton
        navigationItem.title = "회원가입"
        
        profileImageView.drawCircle()
        if let profileURL = URL(string: "https://scontent-icn1-1.xx.fbcdn.net/v/t31.0-8/18815155_1337595106348251_8140129323514750362_o.jpg?oh=6be0546d8c1c4399b1076a7bc49d3e75&oe=5A462372") {
            profileImageView.af_setImage(withURL: profileURL)
        }
    }
    
    func dismissView(button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func joinUser(button: UIBarButtonItem) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
