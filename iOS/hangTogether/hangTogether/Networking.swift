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
        Alamofire.request("\(Config.hostURL)/language").responseJSON { response in
            switch response.result {
                case .success(let response):
                    guard let contents = response as? [String] else { return }
                case .failure(let error):
                    print("error")
                    print(error)
            }
        }
    }
    
    static func getMainList() {
        Alamofire.request("\(Config.hostURL)/post?page=0").responseJSON { response in
            switch response.result {
            case .success(let response):
                guard let contents = response as? [[String:Any]] else { return }
                
                var mainList:[Post] = []
                for content in contents {
                    if let post = Post(JSON: content) {
                        mainList.append(post)
                    }
                }
                NotificationCenter.default.post(name: Notification.Name.mainList , object: self, userInfo: ["mainList":mainList])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func uploadPost(_ parameters: [String:Any]) {
        
        print(parameters)
        Alamofire.request("\(Config.hostURL)/post", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let response):
                NotificationCenter.default.post(name: Notification.Name.uploadPost , object: self, userInfo: ["result":"success"])
            case .failure(let error):
                print(error)
                NotificationCenter.default.post(name: Notification.Name.uploadPost , object: self, userInfo: ["result":"error"])
            }
        }
    }
}
