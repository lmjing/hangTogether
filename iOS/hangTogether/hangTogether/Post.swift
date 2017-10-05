//
//  Post.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 5..
//  Copyright © 2017년 이미정. All rights reserved.
//

import Foundation
import ObjectMapper

class Post: Mappable {
    var id: String!
    //TODO: User 객체 만들어서 정의하기
    var writer: [String:Any] = [:]
    var created: Date!
    var content: String?
    //TODO: String -> Date 바꿔서 해보기
    var tripDate: [String:Date] = [:]
    //TODO: Struct 정의해서 해보기
    var trip: [[String:Any]] = []
    var recruiting: Bool!
    var guide: [[String:Any]] = []
    var volunteer: [String:Any] = [:]
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id     <- map["_id"]
        writer  <- map["writer"]
        created     <- (map["created"], DateTransform())
        
        content  <- map["content"]
        tripDate     <- (map["tripDate"], DateTransform())
        trip  <- map["trip"]
        recruiting  <- map["recruiting"]
        guide     <- map["guide"]
        volunteer  <- map["volunteer"]
    }
    
//    init(map: Map) throws {
//        _id         = try map.value("_id")
//        writer      = try map.value("writer")
//        created     = try map.value("created", using: DateTransform())
//        content     = try map.value("content")
//        tripDate    = try map.value("tripDate")
//        trip        = try map.value("trip")
//        recruiting  = try map.value("recruiting")
//        guide       = try map.value("guide")
//        volunteer   = try map.value("volunteer")
//    }
    
//    mutating func mapping(map: Map) {
//        _id         >>> map["_id"]
//        writer      >>> map["writer"]
//        created     >>> (map["created"], DateTransform())
//        content     >>> map["content"]
//        tripDate    >>> map["tripDate"]
//        trip        >>> map["trip"]
//        recuriting  >>> map["recuriting"]
//        guide       >>> map["guide"]
//        volunteer   >>> map["volunteer"]
//    }
}
