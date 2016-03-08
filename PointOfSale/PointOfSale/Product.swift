//
//  Product.swift
//  PointOfSale
//
//  Created by 왕승현 on 2016. 1. 28..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

struct Product {
    //var image: UIImage
    var name: String
    var barcode: String
    var price: Int
    
    init(/*image: UIImage,*/ name: String, barcode: String, price: Int){
        //self.image = image
        self.name = name
        self.barcode = barcode
        self.price = price
        
    }
}