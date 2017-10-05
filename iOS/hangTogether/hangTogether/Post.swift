//
//  Post.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 5..
//  Copyright © 2017년 이미정. All rights reserved.
//

import Foundation
import ObjectMapper

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
    private(set) var writer: User!
    private(set) var created: Date!
    private(set) var title: String!
    private(set) var content: String?
//    private(set) var tripDate: [String:Date] = [:]
    private(set) var tripDate: String!
    private(set) var trip: [Trip] = []
    private(set) var recruiting: Bool!
    private(set) var guide: [[String:Any]] = []
    private(set) var volunteer: [String:Any] = [:]
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["_id"]
        writer      <- map["writer"]
        created     <- (map["created"], DateTransform())
        title       <- map["title"]
        content     <- map["content"]
//        tripDate    <- (map["tripDate"], DateTransform())
        trip        <- map["trip"]
        recruiting  <- map["recruiting"]
        guide       <- map["guide"]
        volunteer   <- map["volunteer"]
        
        var dateJson:[String:Date] = [:]
        dateJson <- (map["tripDate"], DateTransform())
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let start = dateJson["start"], let end = dateJson["end"] {
            tripDate = "\(dateFormatter.string(from: start)) ~ \(dateFormatter.string(from: end))"
        }
        print(created)
    }
}
