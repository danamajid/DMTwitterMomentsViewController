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
            title: "Learning is cool, but knowing is better",
            caption: "Put it this way, it took me twenty five years to get these plants, twenty five years of blood sweat and tears, and I’m never giving up, I’m just getting started.",
            category: "Mind blowing",
            mainImage: UIImage(named: "weeknd"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let meekdrake = SectionItem(
            title: "Meek Mill vs. Drake: A Full Timeline of the Rap Beef",
            caption: "Don’t ever play yourself. Surround yourself with angels. Lion! Give thanks to the most high.",
            category: "Rap beef",
            mainImage: UIImage(named: "meekvsdrake"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let pac = SectionItem(
            title: "They will try to close the door on you, just open it.",
            caption: "Celebrate success right, the only way, apple. A major key, never panic. Don’t panic, when it gets crazy and rough, don’t panic, stay calm.",
            category: "Mind blowing",
            mainImage: UIImage(named: "pac"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let drake = SectionItem(
            title: "The key is to drink coconut, fresh coconut, trust me.",
            caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla blandit semper nibh, eu interdum eros sollicitudin eu. Nam condimentum.",
            category: "Mind blowing",
            mainImage: UIImage(named: "drake"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let dre = SectionItem(
            title: "The key is to have every key, the key to open every door.",
            caption: "The other day the grass was brown, now it’s green because I ain’t give up. Never surrender.",
            category: "Mind blowing",
            mainImage: UIImage(named: "dre"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let kanye = SectionItem(
            title: "The ladies always say Khaled you smell good, I use no cologne",
            caption: "Bless up. Egg whites, turkey sausage, wheat toast, water. Of course they don’t want us to eat our breakfast, so we are going to enjoy our breakfast.",
            category: "Mind blowing",
            mainImage: UIImage(named: "kanye"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let snoop = SectionItem(
            title: "Stay focused.",
            caption: "Surround yourself with angels, positive energy, beautiful people, beautiful souls, clean heart, angel. In life there will be road blocks but we will over come it.",
            category: "Mind blowing",
            mainImage: UIImage(named: "snoop"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let legend = SectionItem(
            title: "I’m keeping it real with you.",
            caption: " In life there will be road blocks but we will over come it. They never said winning was easy.",
            category: "Mind blowing",
            mainImage: UIImage(named: "legend"),
            dataSource: TopicDummyData().getData(0)
        )
        
        let couples = SectionItem(
            title: " Look at the sunset, life is amazing.",
            caption: " I’m keeping it real with you, so what you going do is have lunch.",
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