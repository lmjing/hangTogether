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
    @IBOutlet weak var nicknameLabel: UILabel!
    
    var delegate: focusToTabDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self.tabBarController as! focusToTabDelegate
        self.navigationItem.title = "마이 페이지"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initUserInfo()
    }
    
    func initUserInfo() {
        if let user = UserDefaults.standard.object(forKey: "user") as? [String:Any],
            let userJson = User(JSON: user) {
            nicknameLabel.text = userJson.nickname
            profileImageView.setProfileImage(user: userJson)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func userInfoEditButtonAction(_ sender: Any) {
        let userEditViewController = UIStoryboard.userEditStoryboard.instantiateViewController(withIdentifier: "userEdit") as! UserEditViewController
        navigationController?.pushViewController(userEditViewController, animated: true)
    }
    
    @IBAction func historyButtonAction(_ sender: Any) {
        let historyTableViewController = UIStoryboard.historyStoryborad.instantiateViewController(withIdentifier: "history") as! HistoryTableViewController
        navigationController?.pushViewController(historyTableViewController, animated: true)
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
