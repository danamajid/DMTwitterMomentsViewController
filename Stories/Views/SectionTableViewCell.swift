//
//  WindowTableViewCell.swift
//  Window
//
//  Created by Dana Majid on 17/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit
import Cartography

class SectionTableViewCell: UITableViewCell {
    
    let cellImage = UIImageView()
    let timeAgo = UILabel()
    let categoryLabel = UILabel()
    let title = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.separatorInset = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero
        
        title.numberOfLines = 2
        title.font = UIFont.systemFontOfSize(20.0)
        self.addSubview(title)
        
        timeAgo.font = UIFont.systemFontOfSize(11.0)
        self.addSubview(timeAgo)
        
        categoryLabel.font = UIFont.boldSystemFontOfSize(11.0)
        categoryLabel.textColor = UIColor.lightGrayColor()
        self.addSubview(categoryLabel)
        
        cellImage.contentMode = .ScaleAspectFill
        cellImage.layer.cornerRadius = 3.0
        cellImage.layer.masksToBounds = true
        self.addSubview(cellImage)
                
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        constrain(title, cellImage, timeAgo, categoryLabel) { title, image, time, category in
            
            image.left == image.superview!.leftMargin + 10
            image.top == image.superview!.topMargin
            image.width == 60
            image.bottom == image.superview!.bottomMargin
            
            category.top == title.superview!.topMargin + 1
            category.left == image.right + 13
            category.width == category.superview!.width
            
            title.left == image.right + 13
            title.right == title.superview!.rightMargin - 10
            title.top == category.bottom + 6
            
            time.bottom == title.superview!.bottomMargin - 1
            time.left == image.right + 13
            time.width == time.superview!.width

        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}