//
//  Config.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 3..
//  Copyright © 2017년 이미정. All rights reserved.
//

import Foundation

class Config {
    static private let plist: NSDictionary? = {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: path) else { return nil }
        return plist
    }()
    
    static public let hostURL: String = {
        return plist?["hostURL"]! as! String
    }()
}
