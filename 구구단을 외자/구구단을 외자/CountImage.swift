//
//  CountDownImage.swift
//  구구단을 외자
//
//  Created by 왕승현 on 2016. 2. 17..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class CountImage: UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func count(){

        self.animationImages = nil
        self.frame.size.width = 200
        self.frame.size.height = 200
        self.frame.origin.x = super.center.x
        self.frame.origin.y = super.center.y
        var imageArray: [UIImage] = [
            UIImage(named: "3.png")!,
            UIImage(named: "2.png")!,
            UIImage(named: "1.png")!]
        self.animationRepeatCount = 1
        self.animationImages = imageArray
        self.animationDuration = 3.0
        self.startAnimating()
        if self.image == nil {
            print("[-] finish animation")
            self.removeFromSuperview()
        }
        
    }
}

