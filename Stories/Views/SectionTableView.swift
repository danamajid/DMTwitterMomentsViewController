//
//  WindowTableView.swift
//  Window
//
//  Created by Dana Majid on 17/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import Foundation
import UIKit
import Cartography


protocol SectionTableViewDelegate {
    func sectionTableScrollViewDidScroll(scrollView: UIScrollView)
}

@objc class SectionTableView: UITableView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var sectionItems: [SectionItem] = []
    var sectionDelegate: SectionTableViewDelegate?
    
    var manager: SectionDataSource? {
        didSet {
            if let data = manager {
                sectionItems = data.getSectionItems()
            
                self.reloadData()
                
            }
        }
    }

    
    // subviews
    private let captionLabel = UILabel()
    private let gradient = UIImageView()
    private let primaryLabel = UILabel()

   
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.rowHeight = 110
        self.separatorInset = UIEdgeInsetsZero
        
        self.delegate = self
        self.dataSource = self
        
        let nibName = UINib(nibName: "SectionTableViewCell", bundle:nil)
        self.registerNib(nibName, forCellReuseIdentifier: "sectionCell")
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.contentOffset = CGPoint(x: 0, y: 0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableItem = sectionItems[indexPath.row]
        let cell: SectionTableViewCell = SectionTableViewCell(style: .Default, reuseIdentifier: "sectionCell")
        
        cell.title.text = tableItem.title
        cell.categoryLabel.text = tableItem.category.uppercaseString
        cell.cellImage.image = tableItem.mainImage
        cell.timeAgo.text = "10 hours ago"
        
        return cell as UITableViewCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tableItem = sectionItems[indexPath.row]
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "openSection", object: WrappedStruct(theValue: tableItem)))
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        sectionDelegate?.sectionTableScrollViewDidScroll(scrollView)
    }

}
