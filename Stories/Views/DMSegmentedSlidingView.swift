//
//  WindowsBarCollectionView.swift
//  Window
//
//  Created by Dana Majid on 16/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit

protocol DMSegmentedSlidingViewDelegate: class {
    func didTapSegmentItem()
}

@objc class DMSegmentedSlidingView: UIView {
    
    // public data source
    internal var tabData: [TabItem] = [] {
        didSet {
            self.refreshTabItems()
        }
    }
    
    // private data source
    private var tabItems : [TabItem] = []
    
    var windowButtons:UIView?
    let kButtonHeightMargin: CGFloat = 10
    let kButtonWidthMargin: CGFloat = 23
    var centerScreen: CGFloat?
    var delegate: DMSegmentedSlidingViewDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = .whiteColor()
        centerScreen = self.frame.width / 2
        
        windowButtons = UIView(frame: bounds)
        addSubview(windowButtons!)
    }
    
    func didTapItem(sender: UIButton!) {

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func refreshTabItems() {
        
        tabItems = tabData
        
        if tabItems.count > 3 {
            if let windowButtons = self.windowButtons {
                windowButtons.subviews.forEach({ $0.removeFromSuperview() }) // remove previous buttons
                
                let firstItem: TabItem = tabItems.first!
                let secondItem: TabItem = tabItems[1]
                let thirdItem: TabItem = tabItems[2]
                
                let lastItem: TabItem = tabItems[tabItems.count - 3]
                let oneToLastItem: TabItem = tabItems[tabItems.count - 2]
                let twoToLastItem: TabItem = tabItems[tabItems.count - 1]
                
                
                tabItems.insert(lastItem, atIndex: 0)
                tabItems.insert(oneToLastItem, atIndex: 1)
                tabItems.insert(twoToLastItem, atIndex: 2)
                
                tabItems.append(firstItem)
                tabItems.append(secondItem)
                tabItems.append(thirdItem)
                
                for (index, item) in tabItems.enumerate() {
                    //item.name.
                    let textSize = item.title.sizeWithAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(12.0)])
                    let leftX = (index == 0 ? 0 : windowButtons.subviews.last!.frame.origin.x + windowButtons.subviews.last!.frame.size.width)
                    let buttonHeight = self.frame.height//textSize.height + (kButtonHeightMargin * 2)
                    let buttonWidth = textSize.width + (kButtonWidthMargin * 2)
                    
                    let button = UIButton(frame: CGRectMake(leftX, 0, buttonWidth, buttonHeight))
                    
                    button.setTitle(item.title.uppercaseString, forState: UIControlState.Normal)
                    button.setTitleColor(UIColor.redColor(), forState: .Selected)
                    button.titleLabel?.font = UIFont.boldSystemFontOfSize(12.0)
                    button.userInteractionEnabled = true
                    button.alpha = 0.5
                    
                    windowButtons.addSubview(button)
                }
                
                
            }
        }
        


    }
    
    func setNewCenter(position: CGFloat, page: CGFloat) {
        
        let offsetPageNo = 3;
        
        let pageNo = Int(page) + offsetPageNo
        let pageNoCenter = Int(round(page)) + offsetPageNo
        let scrollPosition = (page % 1)
        
        
        if windowButtons != nil && windowButtons!.subviews.count >= pageNo && windowButtons!.subviews.count > 1 {
            let referenceItem = windowButtons!.subviews[pageNo - 1] as! UIButton
            let deltaCurrent = referenceItem.frame.origin.x + (referenceItem.frame.width / 2)
            
            let referenceItemNext: UIButton
            let referenceItemNextAlpha: UIButton
            let deltaNext: CGFloat
            
            if (windowButtons!.subviews.count > pageNo) {
                referenceItemNext = windowButtons!.subviews[pageNo] as! UIButton
                deltaNext = referenceItemNext.frame.origin.x + (referenceItemNext.frame.width / 2)
            } else {
                deltaNext = 0
            }
            
            
            let referenceItemAlpha = windowButtons!.subviews[pageNoCenter - 1] as! UIButton
            referenceItemAlpha.alpha = (1 - position) + 0.5
            
            if (windowButtons!.subviews.count > pageNoCenter) {
                referenceItemNextAlpha = windowButtons!.subviews[pageNoCenter] as! UIButton
                referenceItemNextAlpha.alpha = (position * 0.5) + 0.5
            }
            
            
            let newX = centerScreen! - referenceItem.frame.origin.x + ((deltaCurrent - deltaNext) * scrollPosition) - (referenceItem.frame.width / 2)
            let newXStart = centerScreen! - (deltaCurrent)
            
            windowButtons!.frame.origin.x = (scrollPosition == 0 ? newXStart : newX)
        }
    }
}