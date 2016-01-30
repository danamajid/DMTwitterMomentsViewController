//
//  WindowViewCell.swift
//  Window
//
//  Created by Dana Majid on 12/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit
import Cartography

@objc class CollectionViewCell: UICollectionViewCell, SectionTableViewDelegate {
    
    internal var sectionDelegate: SectionTableViewDelegate?
    var offsetY: CGFloat?
    let kTableHeaderHeight: CGFloat! = 450
    var headerViewTop: NSLayoutConstraint?
    var headerViewHeight: NSLayoutConstraint?
    private let captionLabel = UILabel()
    private let gradient = UIImageView()
    private let primaryLabel = UILabel()
    private var primaryItem: SectionItem?
    
    
    let tableView = SectionTableView()
    internal var dataSource : SectionDataSource? {
        didSet {
            if let data = self.dataSource {
                self.tableView.manager = data
                self.primaryItem = data.getPrimaryItem()
                self.drawHeaderView()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.sectionDelegate = self
        self.addSubview(tableView)
        
        
    }
    
    func drawHeaderView() {
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        
        let backgroundImage = UIImageView(frame: CGRectMake(0,0,0,kTableHeaderHeight))
        backgroundImage.userInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: Selector("headerViewTapped:"))
        singleTap.numberOfTapsRequired = 1
        backgroundImage.addGestureRecognizer(singleTap)
        backgroundImage.contentMode = .ScaleAspectFill
        backgroundImage.layer.masksToBounds = true
        backgroundImage.image = primaryItem!.mainImage
        tableView.tableHeaderView = backgroundImage
        
        gradient.image = UIImage(named: "gradient")
        backgroundImage.addSubview(gradient)
        gradient.alpha = 0.7
        
        primaryLabel.font = UIFont.systemFontOfSize(18.0)
        primaryLabel.text = primaryItem!.title
        primaryLabel.numberOfLines = 0
        primaryLabel.textColor = UIColor.whiteColor()
        backgroundImage.addSubview(primaryLabel)
        
        captionLabel.font = UIFont.systemFontOfSize(13.0)
        captionLabel.alpha = 0.9
        captionLabel.text = primaryItem!.caption
        captionLabel.numberOfLines = 0
        captionLabel.textColor = UIColor.whiteColor()
        backgroundImage.addSubview(captionLabel)

        self.setConstraints()
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        constrain(tableView) { tableView in
            tableView.height == tableView.superview!.height
            tableView.width == tableView.superview!.width
            tableView.top == tableView.superview!.top
            tableView.left == tableView.superview!.left
        }

    }
    
    func sectionTableScrollViewDidScroll(scrollView: UIScrollView) {
        sectionDelegate?.sectionTableScrollViewDidScroll(scrollView)
        offsetY = scrollView.contentOffset.y
        print("sectionTableScrollViewDidScroll")
        
        updateScrollIndicator(scrollView)
        updateHeaderViewConstraints()
        //print("delegate is called SectionTableViewDelegate inside CollectionCellView")
    }
    
    func updateScrollIndicator(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: -scrollView.contentOffset.y+kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        }
    }
    
    func setConstraints() {
        constrain(tableView.tableHeaderView!, primaryLabel, captionLabel, gradient) { headerView, primaryLabel, captionLabel, gradient in
            headerViewHeight = headerView.height == kTableHeaderHeight
            headerView.width == headerView.superview!.width
            headerViewTop = headerView.top == headerView.superview!.top
            headerView.left == headerView.superview!.left
            
            captionLabel.bottom == captionLabel.superview!.bottom - 20
            captionLabel.left == captionLabel.superview!.left + 20
            captionLabel.right == captionLabel.superview!.right - 20
            captionLabel.height == 48
            
            primaryLabel.bottom == captionLabel.top - 5
            primaryLabel.right == captionLabel.right
            primaryLabel.left == captionLabel.left
            primaryLabel.height == 18
            
            gradient.left == gradient.superview!.left
            gradient.right == gradient.superview!.right
            gradient.bottom == gradient.superview!.bottom
            gradient.height == 200
            gradient.width == gradient.superview!.width
        }
    }
    
    func headerViewTapped(sender: UIGestureRecognizer) {
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "openSection", object: WrappedStruct(theValue: primaryItem!)))
    }
    
    func updateHeaderViewConstraints() {
        if (tableView.tableHeaderView != nil && offsetY != nil) {
            if headerViewHeight != nil {
                headerViewHeight!.constant = -offsetY! + kTableHeaderHeight
                headerViewTop!.constant = offsetY!
            }
        }
    }
    
    func didEndDisplayingCell() {
        tableView.contentOffset.y = 0
    }
    
    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        print("prefferedLayoutAttr", offsetY)
        updateHeaderViewConstraints()
        return layoutAttributes
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("prepare for reuse")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}