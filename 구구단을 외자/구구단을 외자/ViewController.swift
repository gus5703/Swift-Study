//
//  ViewController.swift
//  구구단을 외자
//
//  Created by 왕승현 on 2016. 2. 16..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var gameStartButton: UIButton!
    
    
    //@IBOutlet weak var a: CountDownImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStartButton.layer.cornerRadius = 10
    
    }

    @IBOutlet weak var button: UIButton!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

