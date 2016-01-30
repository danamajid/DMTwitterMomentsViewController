//
//  WindowViewCell.swift
//  Window
//
//  Created by Dana Majid on 12/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import Foundation
import UIKit
import Cartography

@objc class TopicViewCell: UICollectionViewCell {
    
    let backgroundImage = UIImageView()
    let primaryLabel = UILabel()
    let captionLabel = UILabel()
    let gradient = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        layer.masksToBounds = true
        
        backgroundImage.contentMode = .ScaleAspectFill
        addSubview(backgroundImage)
        
        gradient.image = UIImage(named: "gradient")
        gradient.alpha = 0.7
        addSubview(gradient)
        
        primaryLabel.font = UIFont.systemFontOfSize(18.0)
        primaryLabel.numberOfLines = 0
        primaryLabel.textColor = UIColor.whiteColor()
        addSubview(primaryLabel)
        
        captionLabel.font = UIFont.systemFontOfSize(13.0)
        captionLabel.alpha = 0.9
        captionLabel.numberOfLines = 0
        captionLabel.textColor = UIColor.whiteColor()
        addSubview(captionLabel)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        constrain(backgroundImage, primaryLabel, captionLabel, gradient) { imageView, primaryLabel, captionLabel, gradient in
            
            imageView.width == imageView.superview!.width
            imageView.height == imageView.superview!.height
            imageView.centerX == imageView.superview!.centerX
            imageView.centerY == imageView.superview!.centerY
            
            captionLabel.bottom == captionLabel.superview!.bottom - 20
            captionLabel.left == captionLabel.superview!.left + 20
            captionLabel.right == captionLabel.superview!.right - 20
            captionLabel.height == 50
            
            primaryLabel.bottom == captionLabel.top - 5
            primaryLabel.right == captionLabel.right
            primaryLabel.left == captionLabel.left
            primaryLabel.height == 20
            
            gradient.left == gradient.superview!.left
            gradient.right == gradient.superview!.right
            gradient.bottom == gradient.superview!.bottom
            gradient.height == 200
            gradient.width == gradient.superview!.width
            
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}