//
//  LoginViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 17..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(finishLogin), name: Notification.Name.login, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishLogin(notification: Notification) {
        guard let result = notification.userInfo!["result"] as? String else { print("로그인 실패"); return }
        switch result {
        case "success":
            guard let user = notification.userInfo!["user"] as? [String:Any] else { print("로그인 실패: User 타입이 아님"); return }
            UserDefaults.standard.set(user, forKey: "user")
            dismiss(animated: true, completion: nil)
        case "fail":
            let alert = UIAlertController.okAlert(title: "로그인 실패", message: "아이디와 패스워드를 다시 확인해주세요.")
            present(alert, animated: true, completion: {
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
            })
        default:
            let alert = UIAlertController.okAlert(title: "로그인 실패", message: "죄송합니다. 서버에 문제가 생겨\n로그인에 실패하였습니다.")
            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        guard let email = emailTextField.text, email != "" else {
            let alert = UIAlertController.okAlert(title: nil, message: "이메일을 입력해주세요")
            present(alert, animated: true, completion: nil)
            return
        }
        guard let password = passwordTextField.text, password != "" else {
            let alert = UIAlertController.okAlert(title: nil, message: "비밀번호를 입력해주세요")
            present(alert, animated: true, completion: nil)
            return
        }
        let parameter = [
            "email": email,
            "password": password
        ]
        Networking.login(parameter)
    }
    
    @IBAction func joinButtonAction(_ sender: Any) {
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
