//
//  MessageCell.swift
//  Chatting
//
//  Created by 왕승현 on 2016. 3. 21..
//  Copyright © 2016년 왕승현. All rights reserved.
//


class MessageCell: UITableViewCell {
    var messageNameLabel = UILabel()
    var messageTextLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle , reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        
        self.contentView.addSubview(messageTextLabel)
        self.contentView.addSubview(messageNameLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.messageNameLabel.sizeToFit()
        self.messageNameLabel.frame.origin.x = 10
        self.messageNameLabel.frame.origin.y = 10
        self.messageNameLabel.frame.size.width = 60
        
        self.messageTextLabel.frame.origin.x = 80
        self.messageTextLabel.frame.origin.y = 10
        self.messageTextLabel.frame.size.width = self.contentView.frame.width - self.messageTextLabel.frame.origin.x - 10
        self.messageTextLabel.sizeToFit()
        
    }
}
