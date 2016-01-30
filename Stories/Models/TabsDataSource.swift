//
//  TabsDataSource.swift
//  Window
//
//  Created by Dana Majid on 13/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit

class TabsDataSource{
    var tabItems:[TabItem]
    
    init() {
        tabItems = []
        
        let i1 = TabItem(
            title: "News",
            backgroundImage: UIImage(named: "weeknd"),
            dataSource: SectionDummyData().getData(0)
        )
        
        let i2 = TabItem(
            title: "Entertainment",
            backgroundImage: UIImage(named: "pac"),
            dataSource: SectionDummyData().getData(1)
        )
        
        let i3 = TabItem(
            title: "Tech",
            backgroundImage: UIImage(named: "drake"),
            dataSource: SectionDummyData().getData(2)
        )

        let i4 = TabItem(
            title: "Sports",
            backgroundImage: UIImage(named: "dre"),
            dataSource: SectionDummyData().getData(3)
        )
        
        let i5 = TabItem(
            title: "Fashion",
            backgroundImage: UIImage(named: "kanye"),
            dataSource: SectionDummyData().getData(4)
        )
        
        let i6 = TabItem(
            title: "Fun",
            backgroundImage: UIImage(named: "snoop"),
            dataSource: SectionDummyData().getData(5)
        )
        
        tabItems.append(i1)
        tabItems.append(i2)
        tabItems.append(i3)
        tabItems.append(i4)
        tabItems.append(i5)
        tabItems.append(i6)
        

    }
    
    func getTabItems() -> [TabItem]{
        return tabItems
    }
}