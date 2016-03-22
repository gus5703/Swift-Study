//
//  ChattingViewController.swift
//  Chatting
//
//  Created by 왕승현 on 2016. 3. 20..
//  Copyright © 2016년 왕승현. All rights reserved.
//

struct Message {
    let text: String
    let name: String
    init(text: String, name: String){
        self.text = text
        self.name = name
    }
}

class ChattingViewController: UIViewController {
    @IBOutlet weak var messageTextFied: UITextField!
    @IBOutlet weak var myName: UINavigationItem!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chattingTableView: UITableView!
    
    var messages = [Message]()
    var userName: String!
    var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userdefault = NSUserDefaults.standardUserDefaults()
        userName = userdefault.stringForKey("name")
        
        myName.title = userName
        
        chattingTableView.dataSource = self
        chattingTableView.registerClass(MessageCell.self, forCellReuseIdentifier: "cell")
        getText()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func sendButton(sender: AnyObject) {
        if let message = messageTextFied.text {
            sendText(message)
        }
        getText()
        self.chattingTableView.reloadData()
        messageTextFied.text = ""
    }
    
    
    func sendText(text: String) {
        var object = PFObject(className: "Message")
        object["Text"] = text
        object["name"] = userName
        object.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success == true {
                print("send")
            }
        }
    }
    
    
    func getText() {
        var query = PFQuery(className: "Message")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                print("success")
                if let objects = objects {
                    self.messages = objects.flatMap {
                        guard let text = $0["Text"] as? String else {return nil}
                        guard let name = $0["name"] as? String else {return nil}
                        return Message(text: text, name: name)
                    }
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.chattingTableView.reloadData()
                })
            }
        }
        
        
    }
    
}

extension ChattingViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MessageCell
        
        if messages.count != 0 {
            cell.messageNameLabel.text = messages[indexPath.row].name + " : "
            cell.messageTextLabel.text = messages[indexPath.row].text
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
}