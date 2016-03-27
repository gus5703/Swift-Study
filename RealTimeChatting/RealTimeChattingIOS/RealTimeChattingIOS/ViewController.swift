//
//  ViewController.swift
//  RealTimeChattingIOS
//
//  Created by 왕승현 on 2016. 3. 23..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var chattingTable: UITableView!
	@IBOutlet weak var chatTextField: UITextField!
	@IBOutlet weak var viewBottom: NSLayoutConstraint!
	@IBOutlet weak var tableBottom: NSLayoutConstraint!
	
	let socketIOManager = SocketIOManager.sharedInstance
	let nickname = NSUserDefaults.standardUserDefaults().objectForKey("name") as! String
	
	var chatMessages = [[String:AnyObject]]()
	var chatMessage = [String:AnyObject]() {
		didSet{
			chatMessages.append(self.chatMessage)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		chattingTable.registerClass(ChattingCell.self, forCellReuseIdentifier: "cell")
		chattingTable.dataSource = self
		chattingTable.delegate = self
		chatTextField.delegate = self
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)
		
		socketIOManager.getMessage { (data) -> Void in
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.chatMessage = data
				self.chattingTable.reloadData()})
		}
		
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.view.endEditing(true)
	}
	
	@IBAction func sendButton(sender: AnyObject) {
		if let message = chatTextField.text {
			socketIOManager.sendMessage(nickname, message: message)
			chatTextField.text = ""
		}
	}
}

// MARK: textFieldDelegate
extension ViewController: UITextFieldDelegate {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if let message = chatTextField.text {
			socketIOManager.sendMessage(nickname, message: message)
			chatTextField.text = ""
		}
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidBeginEditing(textField: UITextField) {
		let contentHeight = self.chattingTable.contentSize.height
		let tableHeight = self.chattingTable.frame.height
		self.view.layoutIfNeeded()
		UIView.animateWithDuration(0.5, animations: {
			self.viewBottom.constant = 250
			print(tableHeight, contentHeight)
			if tableHeight < contentHeight {
				self.chattingTable.setContentOffset(CGPointMake(0.0,
					contentHeight - tableHeight + 44 * 5),
					animated: true)
			}
			
			self.view.layoutIfNeeded()
			
			}, completion: nil)
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		self.view.layoutIfNeeded()
		UIView.animateWithDuration(0.5, animations: {
			self.viewBottom.constant = 20
			self.view.layoutIfNeeded()
			
			}, completion: nil)
	}
}

// MARK: UITableDataSource
extension ViewController: UITableViewDataSource {
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		if tableView.frame.height < tableView.contentSize.height {
			tableView.setContentOffset(CGPointMake(0.0, tableView.contentSize.height - tableView.frame.height + 44), animated: true)
		}
		
		return 1
	}
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = chattingTable.dequeueReusableCellWithIdentifier("cell") as! ChattingCell
		let message = chatMessages[indexPath.row]
		cell.messageLabel.text = message["message"] as? String
		cell.nameLabel.text = message["name"] as? String
		
		return cell
		
	}
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return chatMessages.count
	}
	
}

// MARK: UITableDelegate
extension ViewController: UITableViewDelegate {
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		chatTextField.endEditing(true)
	}
	
	
}