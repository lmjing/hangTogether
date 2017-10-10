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
}

extension Notification.Name {
    static let mainList = Notification.Name("getMainList")
}

extension UIStoryboard {
    static let writePostStoryboard = UIStoryboard(name: "WritePost", bundle: nil)
    static let addPlaceStoryboard = UIStoryboard(name: "AddPlace", bundle: nil)
}

extension DateFormatter {
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
}

extension Date {
    func convertString() -> String {
        return DateFormatter.date().string(from: self)
    }
}

extension String {
    func convertDate() -> Date {
        return DateFormatter.date().date(from: self)!
    }
    
    func monthDay() -> String {
        return self.substring(from: self.index(self.endIndex, offsetBy: -5))
    }
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
        toolbar.backgroundColor = UIColor.lightGray
        
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
