//
//  ViewController.swift
//  myFirstGame
//
//  Created by 왕승현 on 2016. 3. 2..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "start" {
            if let gameScene = segue.destinationViewController as? GameViewController {
                print("gameviewcontroller")
                if let text = textField.text {
                    gameScene.people = Int(text)!
                }
            }

        }
    }
    @IBAction func startAction(sender: AnyObject) {
        self.performSegueWithIdentifier("start", sender: self)
    }

}
    