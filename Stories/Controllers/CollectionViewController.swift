//
//  WindowsCollectionView.swift
//  Window
//
//  Created by Dana Majid on 15/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class CollectionViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, DMSegmentedSlidingViewDelegate, SectionTableViewDelegate {
    var collectionView: UICollectionView!
    var segmentedSlidingView: DMSegmentedSlidingView!
    var tabItems: [TabItem] = []
    var lastContentOffset: CGFloat = 0.0
    private var customNavBarTop: NSLayoutConstraint?
    private var previousCustomNavBarTop: NSLayoutConstraint?
    private var customNavBarHeight: NSLayoutConstraint?
    let customTabBar = UIImageView()
    let statusBarBackground = UIImageView(image: UIImage.imageWithColor(UIColor.blackColor()))
    let speedOffset:CGFloat = 0.5
    
    var manager = TabsDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        self.automaticallyAdjustsScrollViewInsets = true
        self.edgesForExtendedLayout = .None
        
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal

        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout);
        collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "windowViewCell");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "statusbarChanged:", name: "statusbarChanged", object: nil)
        
        tabItems = manager.getTabItems()
        if tabItems.count > 1 {
            let firstItem: TabItem = tabItems.first!
            let lastItem: TabItem = tabItems.last!
            tabItems.insert(lastItem, atIndex: 0)
            tabItems.append(firstItem)
        } else {
            collectionView.alwaysBounceHorizontal = true
        }
        
        
        collectionView.backgroundColor = UIColor.whiteColor();
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        
        //self.view.backgroundColor = UIColor.blackColor()
        self.view.addSubview(collectionView!);
        
        
        
        
        constrain(collectionView!) { collectionView in
            
            collectionView.left == collectionView.superview!.left
            collectionView.top == collectionView.superview!.top
            collectionView.right == collectionView.superview!.right
            collectionView.bottom == collectionView.superview!.bottom

        }
        
        statusBarBackground.alpha = 0
        self.view.addSubview(statusBarBackground)
        
        
        customTabBar.image = UIImage(named: "gradient2")
        
        //customTabBar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.70)
        
        segmentedSlidingView = DMSegmentedSlidingView(frame: CGRectMake(0, 25, self.view.frame.width, 36))
        segmentedSlidingView.tabData = manager.tabItems
        segmentedSlidingView.delegate = self
        customTabBar.addSubview(segmentedSlidingView)
        self.view.addSubview(customTabBar)
        
        constrain(segmentedSlidingView, customTabBar, statusBarBackground) { segmentedSlidingView, customTabBar, statusBarBackground in
            
            customNavBarTop = customTabBar.top == customTabBar.superview!.top
            customTabBar.left == customTabBar.superview!.left
            customTabBar.width == customTabBar.superview!.width
            customNavBarHeight = customTabBar.height == 100
            
            statusBarBackground.top == statusBarBackground.superview!.top
            statusBarBackground.left == statusBarBackground.superview!.left
            statusBarBackground.right == statusBarBackground.superview!.right
            statusBarBackground.height == 20
            
            
            segmentedSlidingView.bottom == segmentedSlidingView.superview!.top + 25
            
        }

        self.view.layer.cornerRadius = 3
        self.view.layer.masksToBounds = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        appDelegate.showStatusbar = true
        
        if (appDelegate.firstTime) {
            var token: dispatch_once_t = 0
            dispatch_once(&token) {
                
                appDelegate.firstTime = false
                
                if self.tabItems.count > 1 {
                    self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), atScrollPosition: .Left, animated: false)
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabItems.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let windowItem = tabItems[indexPath.row]
        let cell:CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("windowViewCell", forIndexPath: indexPath) as! CollectionViewCell;
        cell.dataSource = windowItem.dataSource
        cell.sectionDelegate = self
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0;
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
        return CGSizeMake(collectionView.frame.width, collectionView.frame.height);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero; //top,left,bottom,right
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        previousCustomNavBarTop?.constant = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {        
        var lastContentOffsetX:CGFloat = CGFloat(FLT_MIN);

        let currentOffsetX: CGFloat = scrollView.contentOffset.x;
        let currentOffsetY: CGFloat = scrollView.contentOffset.y;
        
        let pageWidth:CGFloat = scrollView.frame.size.width;
        
        let offset:CGFloat = pageWidth * CGFloat(tabItems.count - 2);
        let page:CGFloat = currentOffsetX/pageWidth
        let position:CGFloat = CGFloat((currentOffsetX + (pageWidth / 2)) / pageWidth) % 1
        
        
        
        if(!page.isNaN) {
            segmentedSlidingView?.setNewCenter(position, page: page)
            updateCustomNavBar(-scrollView.contentOffset.y)
            //slideTabBar(page, pageWidth: pageWidth)
        }
        
        if tabItems.count == 1 {
            return;
        }

        if (currentOffsetX < pageWidth && lastContentOffsetX > currentOffsetX) {
            lastContentOffsetX = currentOffsetX + offset;
            scrollView.contentOffset = CGPointMake(lastContentOffsetX, currentOffsetY);
        } else if (currentOffsetX > offset && lastContentOffsetX < currentOffsetX) {
            lastContentOffsetX = currentOffsetX - offset;
            scrollView.contentOffset = CGPointMake(lastContentOffsetX, currentOffsetY);
        } else {
            lastContentOffsetX = currentOffsetX;
        }
                
        
        self.lastContentOffset = scrollView.contentOffset.x;
    }
    
    func slideTabBar(page: CGFloat, pageWidth: CGFloat) {
        let currentPage = Int(round(page))
        let currentPagePoint = CGPointMake(CGFloat(currentPage) * pageWidth, 0)
        let currentPageIndexPath = collectionView.indexPathForItemAtPoint(currentPagePoint)
        let currentPageCellView = collectionView.cellForItemAtIndexPath(currentPageIndexPath!) as? CollectionViewCell
        
        let nextPage = Int(ceil(page))
        let nextPagePoint = CGPointMake(CGFloat(nextPage) * pageWidth, 0)
        let nextPageIndexPath = collectionView.indexPathForItemAtPoint(nextPagePoint)
        if (nextPageIndexPath != nil) {
            //let nextPageCellView = collectionView.cellForItemAtIndexPath(nextPageIndexPath!) as? CollectionViewCell
        }
        
        let prevPage = Int(floor(page))
        let prevPagePoint = CGPointMake(CGFloat(prevPage) * pageWidth, 0)
        let prevPageIndexPath = collectionView.indexPathForItemAtPoint(prevPagePoint)
        if (prevPageIndexPath != nil) {
            //let prevPageCellView = collectionView.cellForItemAtIndexPath(prevPageIndexPath!) as? CollectionViewCell
        }
        
        let speedOffset:CGFloat = 0.5
        let mostOffsetYPossible = -customNavBarHeight!.constant * speedOffset
        
        if (customNavBarTop?.constant != nil) {
            customNavBarTop!.constant = customNavBarTop!.constant + (-customNavBarTop!.constant) * (page % 1) * 0.5
            customTabBar.alpha = ((page % 1) == 0 ? 1 : (page % 1))
        } else {
            customTabBar.alpha = 1
        }

    }
    
    func statusbarChanged(notification:NSNotification) {
        
        let showStatusbar = (notification.object) as? Dictionary<String,Bool>

        appDelegate.showStatusbar = ((showStatusbar?["show"]) != nil ? (showStatusbar?["show"])! : true)
        
        UIView.animateWithDuration(0.3, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
        
    }
    
    func sectionTableScrollViewDidScroll(scrollView: UIScrollView) {
        updateCustomNavBar(-scrollView.contentOffset.y * speedOffset);
    }
    
    func updateCustomNavBar(offsetY: CGFloat) {
        let mostOffsetYPossible = -customNavBarHeight!.constant * speedOffset
        
        if(offsetY < 0) {
            customNavBarTop!.constant = offsetY
            customTabBar.alpha = 1 - ((offsetY / mostOffsetYPossible) * speedOffset)
            
            statusBarBackground.alpha = min((offsetY / mostOffsetYPossible), 0.4)
            
        } else if (offsetY <= mostOffsetYPossible) {
            customNavBarTop!.constant = -mostOffsetYPossible
            statusBarBackground.alpha = 0.4
        } else {
            customNavBarTop!.constant = 0
            customTabBar.alpha = 1
            statusBarBackground.alpha = 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        (cell as! CollectionViewCell).didEndDisplayingCell()
        
    }
    
    func didTapSegmentItem() {
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return !appDelegate.showStatusbar
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Slide
    }
}