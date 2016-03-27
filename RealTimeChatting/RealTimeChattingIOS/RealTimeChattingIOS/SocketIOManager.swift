//
//  SocketIOManager.swift
//  RealTimeChattingIOS
//
//  Created by 왕승현 on 2016. 3. 23..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject {
	static let sharedInstance = SocketIOManager()
	
	var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://127.0.0.1:3000")!)
	
	override init() {
		super.init()
	}
	
	func openConnection() {
		socket.connect()
	}
	
	func closeConnection() {
		socket.disconnect()
	}
	
	func connectUser(nickname: String) {
		socket.emit("connectUser", nickname)
	}
	
	func connectToServerWithNickname(nickname: String, completionHandler: (userList: [[String: AnyObject]]!) -> Void) {
		socket.on("userList") { (dataArray, ack) -> Void in
			completionHandler(userList: dataArray[0] as! [[String: AnyObject]])
		}
	}
	
	func sendMessage(nickname: String, message: String) {
		socket.emit("chatMessage", nickname, message)
	}
	
	func getMessage(completion: (data: [String:AnyObject]) -> Void) {
		var message = [String:AnyObject]()
		
		socket.on("chatMessage") { (dataArray , SocketAck) -> Void in
			
			message["name"] = dataArray[0] as! String
			message["message"] = dataArray[1] as! String
			message["date"] = dataArray[2] as! String
			completion(data: message)
		}
		
		
	}
	
	func g1etMessage(completionHandler: (messageInfo: [String:AnyObject]) -> Void) {
		socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
			var message = [String:AnyObject]()
			message["name"] = dataArray[0] as! String
			message["message"] = dataArray[1] as! String
			
			completionHandler(messageInfo: message)
		}
	}
}
