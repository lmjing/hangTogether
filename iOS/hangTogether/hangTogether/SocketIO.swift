//
//  SocketIO.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 12. 4..
//  Copyright © 2017년 이미정. All rights reserved.
//

import Foundation
import SocketIO

class Socket {
    static let manager = SocketManager(socketURL: URL(string: Config.hostURL)!, config: [.log(false), .compress])
    static let socket = manager.defaultSocket
    
    static func test2() {
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on("chatToMe") { (data, ack) in
            
            if let one = data[0] as? [String:String]{
                print(one["hello"])
                socket.emit("chatToYou", ["test":"ing"])
            }
            print(data)
        }
        
        socket.connect()
    }
}
