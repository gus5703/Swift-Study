//
//  ViewController.swift
//  Chatting
//
//  Created by 왕승현 on 2016. 3. 19..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let userdefault = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if userdefault.valueForKey("name") != nil {
            self.performSegueWithIdentifier("join", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func checkUser() -> Bool {
        let nick = nickNameTextField.text
        let user = PFUser()
        let userdefault = NSUserDefaults.standardUserDefaults()
        
        var check: Bool = false
        
        user.username = nick
        user.password = ""
        user.signUpInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
            if error == nil {
                check = true
                userdefault.setValue(nick , forKey: "name")
                self.performSegueWithIdentifier("join", sender: self)
            } else {
                let alertView = UIAlertController(title: "error", message: "이미 있는 닉네임입니다", preferredStyle: UIAlertControllerStyle.Alert)
                alertView.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertView, animated: true, completion: nil)
                
                check = false
            }
        }
        return check
        
    }
    @IBAction func joinButtonAction(sender: AnyObject) {
        let nick = nickNameTextField.text
        let userdefault = NSUserDefaults.standardUserDefaults()
        if nick == "" {
            let alertView = UIAlertController(title: "error", message: "닉네임을 한자리 이상 적어주세요", preferredStyle: UIAlertControllerStyle.Alert)
            alertView.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertView, animated: true, completion: nil)
        } else if userdefault.stringForKey("name") != nil {
            self.performSegueWithIdentifier("join", sender: self)
        }else if checkUser() == true{
            self.performSegueWithIdentifier("join", sender: self)
        }
        print(userdefault.dictionaryRepresentation())

    }
}

