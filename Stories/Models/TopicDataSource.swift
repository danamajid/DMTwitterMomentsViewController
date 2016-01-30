//
//  TopicDataSource.swift
//  Stories
//
//  Created by Dana Majid on 18/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit

class TopicDataSource {
    var topicItems:[TopicItem]
    
    init(items: [TopicItem]) {
        topicItems = items
    }
    
    func getTopicItems() -> [TopicItem]{
        return topicItems
    }
    
    func getPrimaryItem() -> TopicItem{
        return topicItems.first!
    }
}

class TopicDummyData {
    func getData(index: Int) -> TopicDataSource {
        var dummyItems:[TopicItem] = []
        
        let weeknd = TopicItem(
            title: "Can't feel my face when I'm with you. No shit.",
            caption: "Hello world",
            category: "Mind blowing",
            mainImage: UIImage(named: "weeknd")
        )
        
        let i2 = TopicItem(
            title: "Can't feel my face when I'm with you. No shit.",
            caption: "Hello world",
            category: "Mind blowing",
            mainImage: nil
        )
        
        let i3 = TopicItem(
            title: "Can't feel my face when I'm with you. No shit.",
            caption: "Hello world",
            category: "Mind blowing",
            mainImage: nil
        )
        
        dummyItems.append(weeknd)
        dummyItems.append(i2)
        dummyItems.append(i3)

        return TopicDataSource(items: dummyItems)
    }
}