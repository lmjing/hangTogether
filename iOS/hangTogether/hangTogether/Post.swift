//
//  Post.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 5..
//  Copyright © 2017년 이미정. All rights reserved.
//

import Foundation
import ObjectMapper

//class Trip: Mappable {
//    private(set) var date: Date!
//    private(set) var place: [String:String] = [:]
//    
//    required init?(map: Map) {
//        
//    }
//    
//    func mapping(map: Map) {
//        date <- (map["date"], DateTransform())
//        place <- map["place"]
//    }
//}

struct Trip: Mappable {
    private(set) var date: Date!
    private(set) var place: [String:String] = [:]
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        date <- (map["date"], DateTransform())
        place <- map["place"]
    }
}

class Post: Mappable {
    private(set) var id: String!
    //TODO: User 객체 만들어서 정의하기
//    private(set) var writer: [String:Any] = [:]
    private(set) var writer: User!
    private(set) var created: Date!
    private(set) var content: String?
    private(set) var tripDate: [String:Date] = [:]
    private(set) var trip: [Trip] = []
    private(set) var recruiting: Bool!
    private(set) var guide: [[String:Any]] = []
    private(set) var volunteer: [String:Any] = [:]
    
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
