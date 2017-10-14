//
//  DetailPostViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 15..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class DetailPostViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var userProfileView: UIView!
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView() {
        guard let writer = post.writer else { print("no writer"); return }
        if let profileURL = URL(string: "https://scontent-icn1-1.xx.fbcdn.net/v/t31.0-8/18815155_1337595106348251_8140129323514750362_o.jpg?oh=6be0546d8c1c4399b1076a7bc49d3e75&oe=5A462372") {
            profileImageView.af_setImage(withURL: profileURL)
        }
        nicknameLabel.text = writer.nickname
        userInfoLabel.text = "\(writer.birth.age) \(writer.sex.rawValue)"
        languagesLabel.text = writer.languages.joined(separator: ",")
        
        contentTextView.text = post.content
        designView()
    }
    
    func designView() {
        profileImageView.drawCircle()
        contentTextView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
        contentTextView.drawLine()
        firstButton.drawLine()
        secondButton.drawLine()
    }
    
    //TODO: userProfileView누르면 이동하도록 구현할 것
    func moveUserProfile() {
        let userProfileViewController = UIStoryboard.userProfileStoryboard.instantiateViewController(withIdentifier: "userProfile") as! UserProfileViewController
        userProfileViewController.user = post.writer
        navigationController?.pushViewController(userProfileViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
