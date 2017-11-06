//
//  User.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 5..
//  Copyright © 2017년 이미정. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    enum Sex: String {
        case male = "male", female = "female"
    }
    enum `Type`: String {
        case foreigner = "foreigner", korean = "korean"
    }
    
    private(set) var id: String!
    private(set) var email: String!
    private(set) var password: String!
    private(set) var nickname: String!
    var sex: Sex!
    private(set) var birth: Date!
    private(set) var type: Type!
    private(set) var introduce: String = ""
    private(set) var languages: [String] = []
    private(set) var profileUrl: String?
    
    required init?(map: Map) {
        
    }
    
    init() {}

    func mapping(map: Map) {
        id          <- map["_id"]
        email       <- map["email"]
        password    <- map["password"]
        nickname    <- map["nickname"]
        sex         <- map["sex"]
        birth       <- (map["birth"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZ"))
        type        <- map["type"]
        introduce   <- map["introduce"]
        languages   <- map["languages"]
        profileUrl  <- map["profileUrl"]
    }
}
