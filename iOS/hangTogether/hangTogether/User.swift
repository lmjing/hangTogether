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
    //MARK: 비밀번호 굳이 필요없을 것 같아서 저장안하는데 나중에 필요하면 갖다 쓰기
//    var password: String!
    private(set) var nickname: String!
    var sex: Sex!
    private(set) var birth: Date!
    private(set) var type: Type!
    private(set) var introduce: String?
    private(set) var languages: [String] = []
    private(set) var profileUrl: String?
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        id          <- map["_id"]
        email       <- map["email"]
        nickname    <- map["nickname"]
        sex         <- map["sex"]
        birth       <- map["birth"]
        type        <- map["type"]
        introduce   <- map["introduce"]
        languages   <- map["languages"]
        profileUrl  <- map["profileUrl"]
    }
}
