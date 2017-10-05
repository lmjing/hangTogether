//
//  Networking.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 3..
//  Copyright © 2017년 이미정. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    static func getLanguages() {
        Alamofire.request("\(Config.hostURL)/language").responseJSON {
            response in
            switch response.result {
                case .success(let response):
                    print("Validation Successful")
                    guard let contents = response as? [String] else { return }
                    print(contents)
                case .failure(let error):
                    print("error")
                    print(error)
            }
        }
    }
    
    static func getMainList() {
        Alamofire.request("\(Config.hostURL)/post?page=0").responseJSON {
            response in
            switch response.result {
            case .success(let response):
                guard let contents = response as? [[String:Any]] else { return }
                for content in contents {
                    if let post = Post(JSON: content) {
//                        print(post.id)
//                        print(post.content!)
//                        print(post.created)
//                        print(post.guide)
//                        print(post.recruiting)
//                        print(post.trip)
//                        print(post.tripDate)
//                        print(post.volunteer)
                        print(post.writer.type)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
