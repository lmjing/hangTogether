//
//  UserEditViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 11. 6..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class UserEditViewController: UIViewController {

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var currentPWTextField: UITextField!
    @IBOutlet weak var newPWTextField: UITextField!
    @IBOutlet weak var newPWCheckTextField: UITextField!
    
    lazy var user: User = {
        if let data = UserDefaults.standard.object(forKey: "user") as? [String:Any],
            let user = User(JSON: data){
            return user
        }
        return User()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        introduceTextView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
        introduceTextView.drawLine()
        
        let okButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check"), style: .done, target: self, action: #selector(editUser))
        navigationItem.setRightBarButton(okButton, animated: true)
        
        initUserInfo()
    }
    
    func initUserInfo() {
        nicknameTextField.text = user.nickname
        introduceTextView.text = user.introduce
    }
    
    func editUser(button: UIBarButtonItem) {
        var newInput: [String:String] = [
            "password": user.password,
            "nickname": user.nickname,
            "introduce": user.introduce
        ]
        if let currentPW = currentPWTextField.text, let newPW = newPWTextField.text, let newPWCheck = newPWCheckTextField.text {
            if currentPW.isEmpty || newPW.isEmpty || newPWCheck.isEmpty {
                let alert = UIAlertController.okAlert(title: nil, message: "미 입력된 사항이 존재합니다.")
                present(alert, animated: true, completion: nil); return
            }
            
            guard user.password == currentPW else {
                // 현재 비밀번호 일치하지 않는 경우
                let alert = UIAlertController.okAlert(title: nil, message: "입력하신 비밀번호가 현재 비밀번호와 일치하지 않습니다.")
                    present(alert, animated: true, completion: {
                        self.currentPWTextField.text = nil
                    }); return
            }
            guard newPW == newPWCheck else {
                // 새로운 비밀번호 서로 일치하지 않을 경우
                let alert = UIAlertController.okAlert(title: nil, message: "입력하신 새로운 비밀번호가 서로 일치하지 않습니다.")
                present(alert, animated: true, completion: {
                    self.newPWTextField.text = nil
                    self.newPWCheckTextField.text = nil
                }); return
            }
            newInput["password"] = newPW
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
