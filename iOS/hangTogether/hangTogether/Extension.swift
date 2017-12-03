//
//  Extension.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 4..
//  Copyright © 2017년 이미정. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let pointColor = UIColor(red: 53/255, green: 186/255, blue: 188/255, alpha: 1)
    static let buttonBackgroundColor = UIColor(red: 248, green: 248, blue: 248, alpha: 1)
}

extension Notification.Name {
    static let mainList = Notification.Name("getMainList")
    static let uploadPost = Notification.Name("uploadPost")
    static let login = Notification.Name("login")
    static let duplicationCheck = Notification.Name("duplicaitonCheck")
    static let join = Notification.Name("join")
    static let getLanguages = Notification.Name("getLanguages")
    static let userEdit = Notification.Name("getUserEdit")
    static let history = Notification.Name("getHistory")
}

extension UIStoryboard {
    static let writePostStoryboard = UIStoryboard(name: "WritePost", bundle: nil)
    static let addPlaceStoryboard = UIStoryboard(name: "AddPlace", bundle: nil)
    static let userProfileStoryboard = UIStoryboard(name: "UserProfile", bundle: nil)
    static let detailPostStoryboard = UIStoryboard(name: "DetailPost", bundle: nil)
    static let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
    static let joinStoryboard = UIStoryboard(name: "Join", bundle: nil)
    static let userEditStoryboard = UIStoryboard(name: "UserEdit", bundle: nil)
    static let historyStoryborad = UIStoryboard(name: "History", bundle: nil)
}

extension DateFormatter {
    static func time() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.timeZone = NSTimeZone.system
        
        return formatter
    }
    
    static func date() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = NSTimeZone.system
        
        return formatter
    }
}

extension UIAlertController {
    static func okAlert(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
    static func okAlert(title: String?, message: String?, action: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: action)
        alert.addAction(action)
        return alert
    }
    
    static func cancleOkAlert(title: String?, message: String?, action: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: action)
        let cancle = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancle)
        return alert
    }
    
    static func loginAlert(title: String, vc: UIViewController, moveTab: Int) -> UIAlertController {
        let alert = UIAlertController(title: title, message: "로그인 후 이용할 수 있습니다.\n로그인 하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            print("여기에 로그인 화면으로 이동하는 코드 넣기!")
            let loginVC = UIStoryboard.loginStoryboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
            loginVC.wantedPage = moveTab
            loginVC.delegate = vc as? focusToTabDelegate
            vc.present(loginVC, animated: true, completion: nil)
        }
        let cancle = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancle)
        return alert
    }
}

extension Date {
    var string: String {
        get {
            return DateFormatter.date().string(from: self)
        }
    }
    
    var time: String {
        get {
            return DateFormatter.time().string(from: self)
        }
    }
    
    var age: String {
        get {
            let diff = -(self.timeIntervalSinceNow / 60 / 60 / 24 / 365)
            let age = Int(diff / 10) * 10
            return "\(age)대"
        }
    }
}

extension String {
    var date: Date {
        get {
            return DateFormatter.date().date(from: self)!
        }
    }
    
    var monthDay: String {
        get {
            return self.substring(from: self.index(self.endIndex, offsetBy: -5))
        }
    }
    
    /* 정규식 확인
    func check() -> CGFloat {
        let englishRegex = try! NSRegularExpression(pattern: "[a-zA-Z ]", options: [])
        let hangleRegex = try! NSRegularExpression(pattern: "[가-힣]", options: [])
        
        let englishCount = englishRegex.numberOfMatches(in: self, options: [], range: NSMakeRange(0, self.utf16.count))
        let hangleCount = hangleRegex.numberOfMatches(in: self, options: [], range: NSMakeRange(0, self.utf16.count))
        
        return CGFloat(0 + englishCount + hangleCount)
    }
 */
}

extension UIToolbar {
    func datePicker(items: [UIBarButtonItem]) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor.lightGray
        
        toolbar.setItems(items, animated: true)
        return toolbar
    }
}

extension UIDatePicker {
    func withTextField(_ textField: UITextField, selector: Selector) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor.white
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: selector)
        doneButton.tintColor = UIColor.pointColor
        doneButton.tag = textField.tag
        toolbar.setItems([doneButton], animated: true)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = self
        self.datePickerMode = .date
        self.backgroundColor = UIColor.white
    }
}

extension IndexPath {
    func equalTo(_ indexPath: IndexPath) -> Bool {
        if self.row == indexPath.row && self.section == indexPath.section {
            return true
        }
        return false
    }
}

extension UIImageView {
    func drawCircle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}

extension UIView {
    func drawLine() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
}

extension PaddingLabel {
    
    func notSelect() {
        self.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        self.font = UIFont.boldSystemFont(ofSize: 12)
        self.text = "not select"
        self.textColor = UIColor.black
        self.textAlignment = .center
    }
    
    func language(text: String) {
        self.backgroundColor = UIColor.pointColor
        self.textColor = UIColor.white
        self.font = UIFont.boldSystemFont(ofSize: 12)
        self.text = text
        self.textAlignment = .center
    }
}
