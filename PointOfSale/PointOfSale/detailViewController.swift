//
//  detailViewController.swift
//  PointOfSale
//
//  Created by 왕승현 on 2016. 2. 1..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class detailViewController: UIViewController{
    let productName = UILabel()
    let barcode = UILabel()
    let barcodeNumber = UILabel()
    let price = UILabel()
    let priceNumber = UILabel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let barcodeNumberRightConstraint = NSLayoutConstraint(item: self.barcodeNumber, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 10.0)

        //view.translatesAutoresizingMaskIntoConstraints = false;


        self.view.backgroundColor = UIColor.whiteColor()
        
        self.productName.font = UIFont(name: "System", size: 25)
        self.productName.font.fontWithSize(25.0)
        self.productName.sizeToFit()
        self.productName.center.x = self.view.center.x
        self.productName.frame.origin.y = 100
        self.view.addSubview(productName)

        self.barcodeNumber.sizeToFit()
        self.barcodeNumber.frame.origin.y = 200
        self.barcodeNumber.center.x = self.view.center.x
        self.view.addSubview(barcodeNumber)

        
        self.barcode.sizeToFit()
        self.barcode.frame.origin.y = 200
        self.barcode.frame.origin.x = 50
        self.barcode.textAlignment = .Right
        self.view.addSubview(barcode)
        
        self.priceNumber.sizeToFit()
        self.priceNumber.frame.origin.y = 300
        self.priceNumber.center.x = self.view.center.x
        self.view.addSubview(priceNumber)
        
        self.price.sizeToFit()
        self.price.frame.origin.y = 300
        self.price.frame.origin.x = 50
        self.price.textAlignment = .Right
        self.view.addSubview(price)
        
    }
}
