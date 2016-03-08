//
//  File.swift
//  구구단을 외자
//
//  Created by 왕승현 on 2016. 2. 20..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class Count: UIViewController{
    let CountFrame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
    var countImage: CountImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        countImage = CountImage(frame: CountFrame)
        countImage.count()
        if countImage.image != nil {
            print("ASdf")
        }
    
        self.view.addSubview(countImage)
    }
}
