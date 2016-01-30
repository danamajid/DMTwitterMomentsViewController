//
//  SectionDetailViewController.swift
//  Window
//
//  Created by Dana Majid on 18/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit
import Cartography

class SectionDetailViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    var imageView: UIImageView = UIImageView();
    var collectionView: UICollectionView?
    var sectionItem:SectionItem!;
    var topicItems: [TopicItem]!

    deinit {
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "statusbarChanged", object: ["show": true] as Dictionary<String, AnyObject>))
        
    }
    
    init(tappedSection: SectionItem) {
        super.init(nibName: nil, bundle: nil)
        sectionItem = tappedSection
        topicItems = tappedSection.dataSource.getTopicItems()
        topicItems.append(TopicItem())

        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal

        collectionView = UICollectionView(frame: UIScreen.mainScreen().bounds, collectionViewLayout: flowLayout);
        collectionView!.registerClass(TopicViewCell.self, forCellWithReuseIdentifier: "topicViewCell");
        collectionView!.delegate = self;
        collectionView!.dataSource = self;
        collectionView!.alwaysBounceVertical = false
        collectionView!.alwaysBounceHorizontal = true
        
        collectionView!.backgroundColor = UIColor.blackColor();
        collectionView!.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView!.showsHorizontalScrollIndicator = false
        collectionView!.pagingEnabled = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "statusbarChanged", object: ["show": false] as Dictionary<String, AnyObject>))

        self.view.backgroundColor = UIColor.blackColor()
        self.view.layer.cornerRadius = 3
        self.view.layer.masksToBounds = true
        self.navigationController?.navigationBarHidden = true
        
        self.automaticallyAdjustsScrollViewInsets = true
        self.edgesForExtendedLayout = .None
        
        self.view.addSubview(collectionView!)
        
        constrain(collectionView!, imageView) { collectionView, imageView in
            collectionView.width == collectionView.superview!.width
            collectionView.height == collectionView.superview!.height
            collectionView.centerX == collectionView.superview!.centerX
            collectionView.centerY == collectionView.superview!.centerY
            
//            imageView.width == collectionView.width
//            imageView.height == collectionView.height
//            imageView.centerX == collectionView.centerX
//            imageView.centerY == collectionView.centerY
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicItems.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let windowItem: TopicItem = topicItems[indexPath.row]
        let cell:TopicViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("topicViewCell", forIndexPath: indexPath) as! TopicViewCell;
        
        if (indexPath.row == 0) {
            cell.backgroundImage.image = sectionItem.mainImage
            cell.primaryLabel.text = sectionItem.title
            cell.captionLabel.text = sectionItem.caption
        } else {
            cell.backgroundImage.image = windowItem.mainImage
            cell.primaryLabel.text = "This is a tweet on page \(indexPath.row)"
        }
        
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width, collectionView.frame.height);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero;
    }
    
    func tapCloseButton() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Slide
    }
}
