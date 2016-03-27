//
//  ChattingCell.swift
//  RealTimeChattingIOS
//
//  Created by 왕승현 on 2016. 3. 24..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class ChattingCell: UITableViewCell {
	var messageLabel: UILabel = UILabel()
	var nameLabel: UILabel = UILabel()
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		
		self.contentView.addSubview(self.messageLabel)
		self.contentView.addSubview(self.nameLabel)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.nameLabel.sizeToFit()
		self.nameLabel.frame.origin.x = 10
		self.nameLabel.frame.origin.y = 10
		self.nameLabel.frame.size.width = 100
		
		self.messageLabel.sizeToFit()
		self.messageLabel.frame.origin.x = 110
		self.messageLabel.frame.origin.y = 10
		
	}
	
}
