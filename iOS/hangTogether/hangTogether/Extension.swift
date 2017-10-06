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
