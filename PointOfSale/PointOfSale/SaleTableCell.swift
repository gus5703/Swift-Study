//
//  SaleTableCell.swift
//  PointOfSale
//
//  Created by 왕승현 on 2016. 2. 9..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class SaleTableCell: UITableViewCell{
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.priceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let nameLabelPoint = CGPoint(x: 30, y: 10)
        let priceLabelPoint = CGPoint(x: screenWidth - 120 , y: 10)
        
        self.nameLabel.sizeToFit()
        self.nameLabel.frame.origin = nameLabelPoint
        self.nameLabel.frame.size.width = 220
        
        self.priceLabel.sizeToFit()
        self.priceLabel.frame.origin = priceLabelPoint
        self.priceLabel.frame.size.width = 100
        self.priceLabel.leadingAnchor
        self.priceLabel.alignmentRectInsets().left
        self.priceLabel.textAlignment = .Right
        
        
    }
}
