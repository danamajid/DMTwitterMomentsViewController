//
//  SectionDataSource.swift
//  Window
//
//  Created by Dana Majid on 18/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit

class SectionDataSource {
    var sectionItems:[SectionItem]
    
    init(items: [SectionItem]) {
        sectionItems = items
    }
    
    func getSectionItems() -> [SectionItem]{
        var x: [SectionItem] = sectionItems;
        x.removeAtIndex(0)
        
        return x
    }
    
    func getPrimaryItem() -> SectionItem{
        return sectionItems.first!
    }
}

class SectionDummyData {
    func getData(index: Int) -> SectionDataSource {
        var dummyItems:[SectionItem] = []
        
        let weeknd = SectionItem(
            title: "Can't feel my face when I'm with you. No shit.",
            caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla blandit semper nibh, eu interdum eros sollicitudin eu. Nam condimentum.",
            category: "Mind blowing",
            mainImage: UIImage(named: "weeknd"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let meekdrake = SectionItem(
            title: "Meek Mill vs. Drake: A Full Timeline of the Rap Beef",
            caption: "Late Tuesday, Meek Mill took to Twitter to call out Drake for not writing his own raps, claiming Drake didn't promote Meek Mill's album.",
            category: "Rap beef",
            mainImage: UIImage(named: "meekvsdrake"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let pac = SectionItem(
            title: "It's the game of life. Do I win or do I lose?",
            caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla blandit semper nibh, eu interdum eros sollicitudin eu. Nam condimentum.",
            category: "Mind blowing",
            mainImage: UIImage(named: "pac"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let drake = SectionItem(
            title: "Started from the bottom now we here",
            caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla blandit semper nibh, eu interdum eros sollicitudin eu. Nam condimentum.",
            category: "Mind blowing",
            mainImage: UIImage(named: "drake"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let dre = SectionItem(
            title: "The Next Episode",
            caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla blandit semper nibh, eu interdum eros sollicitudin eu. Nam condimentum.",
            category: "Mind blowing",
            mainImage: UIImage(named: "dre"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let kanye = SectionItem(
            title: "The Weeknd",
            caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla blandit semper nibh, eu interdum eros sollicitudin eu. Nam condimentum.",
            category: "Mind blowing",
            mainImage: UIImage(named: "kanye"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let snoop = SectionItem(
            title: "Lodie dodie, we like to party. We don't bother nobody.",
            caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla blandit semper nibh, eu interdum eros sollicitudin eu. Nam condimentum.",
            category: "Mind blowing",
            mainImage: UIImage(named: "snoop"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let legend = SectionItem(
            title: "Save room for my love. Please?",
            caption: "Hello world",
            category: "Mind blowing",
            mainImage: UIImage(named: "legend"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let couples = SectionItem(
            title: "Another day another dawn, come on come on",
            caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla blandit semper nibh, eu interdum eros sollicitudin eu. Nam condimentum.",
            category: "Mind blowing",
            mainImage: UIImage(named: "Couples"),
            dataSource: TopicDummyData().getData(0)
        )
        
        
        
        if index == 0 {
            dummyItems.append(weeknd)
            dummyItems.append(couples)
            dummyItems.append(dre)
            dummyItems.append(snoop)
            dummyItems.append(couples)
        } else if index == 1 {
            dummyItems.append(meekdrake)
            dummyItems.append(pac)
            dummyItems.append(weeknd)
            dummyItems.append(couples)
            dummyItems.append(snoop)
        } else if index == 2 {
            dummyItems.append(drake)
            dummyItems.append(couples)
            dummyItems.append(weeknd)
            dummyItems.append(weeknd)
            dummyItems.append(pac)
            dummyItems.append(snoop)
        } else if index == 3 {
            dummyItems.append(dre)
            dummyItems.append(couples)
            dummyItems.append(snoop)
        } else if index == 4 {
            dummyItems.append(kanye)
            dummyItems.append(weeknd)
            dummyItems.append(weeknd)
            dummyItems.append(pac)
            dummyItems.append(snoop)
        } else if index == 5 {
            dummyItems.append(snoop)
            dummyItems.append(dre)
            dummyItems.append(pac)
            dummyItems.append(snoop)
        } else if index == 6 {
            dummyItems.append(legend)
            dummyItems.append(weeknd)
            dummyItems.append(couples)
        }
        
        
        
        return SectionDataSource(items: dummyItems)
    }
}