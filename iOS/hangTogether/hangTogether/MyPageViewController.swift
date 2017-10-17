//
//  MyPageViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 17..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit
import AlamofireImage

class MyPageViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    
    var delegate: focusToTabDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self.tabBarController as! focusToTabDelegate
        self.navigationItem.title = "마이 페이지"
        initProfileImageView()
    }
    
    func initProfileImageView() {
        profileImageView.drawCircle()
        if let profileURL = URL(string: "https://scontent-icn1-1.xx.fbcdn.net/v/t31.0-8/18815155_1337595106348251_8140129323514750362_o.jpg?oh=6be0546d8c1c4399b1076a7bc49d3e75&oe=5A462372") {
            profileImageView.af_setImage(withURL: profileURL)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func userInfoEditButtonAction(_ sender: Any) {
    }
    
    @IBAction func historyButtonAction(_ sender: Any) {
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        if UserDefaults.standard.dictionary(forKey: "user") != nil {
            let alert = UIAlertController.cancleOkAlert(title: "로그아웃", message: "정말 로그아웃 하시겠습니까?", action: { _ in
                UserDefaults.standard.removeObject(forKey: "user")
                
                self.delegate?.focusOn(0)
            })
            present(alert, animated: true, completion: nil)
        }else {
            print("logout error: 유저 정보가 없음")
        }
    }
}
