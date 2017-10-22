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
    
    //TODO: TextField delegate로 텍스트 입력 받거나 데이터 변경된 경우 nicknameCheck = false로 바꾸기
    var userCheck: [Bool] = [false, false] // 0 : email, 1 : nickname
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameCheckButton.addTarget(self, action: #selector(duplicationCheck), for: .touchUpInside)
        emailCheckButton.addTarget(self, action: #selector(duplicationCheck), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(getCheckResult), name: Notification.Name.joinCheck, object: nil)
        
        // navigation 설정
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
    
    func getCheckResult(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String:Any] else { return }
        guard let type = userInfo["type"] as? Int else { return }
        guard let status = userInfo["status"] as? Bool else { return }
        guard let message = userInfo["message"] as? String else { return }
        if status {
            userCheck[type] = true
        }else {
            userCheck[type] = false
            if type == 0 {
                emailTextField.text = nil
            }else {
                nicknameTextField.text = nil
            }
        }
        
        let alert = UIAlertController.okAlert(title: nil, message: message)
        present(alert, animated: true, completion: nil)
    }
    
    func duplicationCheck(button: UIButton) {
        switch button.tag {
        case 1: // email check
            if let email = emailTextField.text, email != "" {
                Networking.checkUserInfo(email: email, nickname: nil)
            }else {
                let alert = UIAlertController.okAlert(title: nil, message: "email을 입력해주세요.")
                present(alert, animated: true, completion: nil); return
            }
        case 2: // nickname check
            if let nickname = nicknameTextField.text, nickname != "" {
                Networking.checkUserInfo(email: nil, nickname: nickname)
            }else {
                let alert = UIAlertController.okAlert(title: nil, message: "nickname을 입력해주세요.")
                present(alert, animated: true, completion: nil); return
            }
        default: break
        }
    }
    
    func dismissView(button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func joinUser(button: UIBarButtonItem) {
        guard let email = emailTextField.text, email != "", userCheck[1] else  {
            let alert = UIAlertController.okAlert(title: nil, message: "email을 입력해주세요.")
            present(alert, animated: true, completion: nil); return
        }
        guard let nickname = nicknameTextField.text, nickname != "", userCheck[0] else {
            let alert = UIAlertController.okAlert(title: nil, message: "nickname 중복체크를 해주세요.")
            present(alert, animated: true, completion: nil); return
        }
        guard let password = passwordTextField.text, let passwordCheck = passwordCheckTextField.text, passwordCheck == password else {
            let alert = UIAlertController.okAlert(title: nil, message: "password가 일치하지 않습니다.")
            present(alert, animated: true, completion: nil); return
        }
        //TODO: 데이터 형식 일치하는지 확인 할 것\
        guard let birth = birthTextField.text, birth != "" else {
            let alert = UIAlertController.okAlert(title: nil, message: "생년월일을 입력해주세요.")
            present(alert, animated: true, completion: nil); return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
