//
//  TopicItem.swift
//  Stories
//
//  Created by Dana Majid on 18/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit

struct TopicItem {
    var title: String?
    var caption: String?
    var category: String?
    var mainImage: UIImage?
    
    init() {
        
    }
    
    init(title: String?, caption: String?, category: String?, mainImage: UIImage?) {
        self.title = title
        self.caption = caption
        self.category = category
        self.mainImage = mainImage
    }
}