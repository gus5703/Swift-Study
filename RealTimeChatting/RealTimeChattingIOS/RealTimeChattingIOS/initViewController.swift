//
//  initViewController.swift
//  RealTimeChattingIOS
//
//  Created by 왕승현 on 2016. 3. 27..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class initViewController: UIViewController {

	@IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.view.endEditing(true)
	}
	
	@IBAction func buttonAction(sender: AnyObject) {
		if nameTextField.text == "" {
			let alertController = UIAlertController(title: "닉네임 확인", message:"닉네임을 1자 이상 입력해주세요", preferredStyle: UIAlertControllerStyle.Alert)
			
			alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default,handler: nil))
			
			self.presentViewController(alertController, animated: true, completion: nil)
		
			
		} else {
			let name = nameTextField.text
		NSUserDefaults.standardUserDefaults().setObject(name, forKey: "name")
			self.performSegueWithIdentifier("main", sender: self)
		}
	}
}
