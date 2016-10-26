//
//  ActionSheetView.swift
//  ActionSheet
//
//  Created by Dipansha on 6/2/16.
//  Copyright © 2016 Dipansha. All rights reserved.
//

import UIKit

var screenHeight = UIScreen.mainScreen().bounds.height
var screenWidth = UIScreen.mainScreen().bounds.width

enum ActionSheetType {
    case Table, Collection
}

class ActionSheetView: UIView, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var titleBottom: NSLayoutConstraint!
    
    @IBOutlet weak var titleTop: NSLayoutConstraint!
    // MARK: Variables
    var actionSheetProperties : ActionSheetProperties = ActionSheetProperties()
    var selectionHandler: ((String, Int) -> Void)?
    
    
    func createView(actionSheetProperties: ActionSheetProperties, selectionHandler: ((String, Int) -> Void)?)
    {
        
        self.actionSheetProperties = actionSheetProperties
        
        // Set frame of the view
        var frame = UIScreen.mainScreen().bounds
        let height = (frame.height * actionSheetProperties.minPercentage)/100
        frame.size.height = height
        frame.origin.y = (UIScreen.mainScreen().bounds.height ?? 0) - frame.height
        self.frame = frame
        
        // Register cell
        self.tableView.registerNib(UINib(nibName: "ActionSheetTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionSheetTableViewCell")
        self.collectionView.registerNib(UINib(nibName: "ActionSheetCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActionSheetCollectionViewCell")
        
        // Set delegates
        if actionSheetProperties.type == ActionSheetType.Table {
            
            tableView.delegate = self
            tableView.dataSource = self
            
            // To remove extra rows
            self.tableView.tableFooterView = UIView()
            
            // Don't show collection view
            collectionView.hidden = true
        } else {
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
            // Don't show table view
            tableView.hidden = true
        }
        
        // Disable table view scroll
        tableView.scrollEnabled = false
        collectionView.scrollEnabled = false
        
        // Set title
        self.titleLabel.text = actionSheetProperties.titleLabelText
        self.titleLabel.font = actionSheetProperties.titleTextFont
        self.titleLabel.textColor = actionSheetProperties.titleTextColor
        
        if actionSheetProperties.titleLabelText.characters.count == 0 {
            self.titleTop.constant = 0
            self.titleBottom.constant = 0
            self.separator.hidden = true
        }
        
        
        // Add swipe up and down gestures to the view
        let upgestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ActionSheetView.swipeUpGestureRecognized(_:)))
        upgestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        self.addGestureRecognizer(upgestureRecognizer)
        
        let downgestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ActionSheetView.swipeDownGestureRecognized(_:)))
        downgestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        self.addGestureRecognizer(downgestureRecognizer)
        
        
        self.selectionHandler = selectionHandler
        
        // Set colors
        separator.backgroundColor = self.actionSheetProperties.separatorColor
        self.titleView.backgroundColor = UIColor.whiteColor()
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.collectionView.backgroundColor = UIColor.whiteColor()
        
    }
    
    // MARK: Table view functions
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.actionSheetProperties.headers?[section]
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.actionSheetProperties.headers?.count > 0 {
            return 30
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        // border
        let border = UIView(frame: CGRectMake(0,header.frame.height - 1,header.bounds.width,1))
        border.backgroundColor = UIColor.blackColor()
        header.addSubview(border)
        
        header.contentView.backgroundColor = UIColor.clearColor()
        header.textLabel?.textColor = actionSheetProperties.headerTextColor
        header.textLabel?.font = actionSheetProperties.headerTextFont
        header.backgroundView?.backgroundColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let selected = actionSheetProperties.data?[indexPath.section][indexPath.row] {
            self.selectionHandler?(selected, indexPath.section)
        } else {
            self.selectionHandler?("", 0)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return sections' count
        if let count = actionSheetProperties.data?.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 36.5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ActionSheetTableViewCell", forIndexPath: indexPath) as! ActionSheetTableViewCell
        cell.configureCell(actionSheetProperties.data?[indexPath.section][indexPath.row], rowTextColor: actionSheetProperties.cellTextColor, rowTextFont: actionSheetProperties.cellTextFont)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return cell counts for every section
        if let count = actionSheetProperties.data?[section].count {
            return count
        } else {
            return 0
        }
    }
    
    // MARK: Collection view functions
    func collectionView(collectionView: UICollectionView, titleForHeaderInSection section: Int) -> String? {
        return self.actionSheetProperties.headers?[section]
    }
    
    func collectionView(collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.actionSheetProperties.headers?.count > 0 {
            return 30
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.backgroundColor = UIColor.whiteColor()
        header.textLabel?.textColor = actionSheetProperties.headerTextColor
        header.textLabel?.font = actionSheetProperties.headerTextFont
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return cell counts for every section
        if let count = actionSheetProperties.data?[section].count {
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let selected = actionSheetProperties.data?[indexPath.section][indexPath.row] {
            self.selectionHandler?(selected, indexPath.section)
        } else {
            self.selectionHandler?("", 0)
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // Return sections' count
        if let count = actionSheetProperties.data?.count {
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // Configure cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ActionSheetCollectionViewCell", forIndexPath: indexPath) as! ActionSheetCollectionViewCell
        cell.configureCell(actionSheetProperties.data?[indexPath.section][indexPath.row], rowTextColor: actionSheetProperties.cellTextColor, rowTextFont: actionSheetProperties.cellTextFont, iconTextFont: actionSheetProperties.iconTextFont, iconText: actionSheetProperties.icons?[indexPath.section][indexPath.row], iconTextColor: actionSheetProperties.iconTextColor)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = UIScreen.mainScreen().bounds.width / 3 - 30
        let height: CGFloat = 75
        return CGSize(width: width, height: height)
        
    }
    
    // MARK: Swipe gestures
    func swipeUpGestureRecognized(sender: AnyObject?) {
        
        // If whole table is not visible, enable the scroll
        if self.wholeTableVisible() == false {
            
            // Set the full size frame
            var frame = UIScreen.mainScreen().bounds
            let maxHeight = (frame.height * (actionSheetProperties.maxPercentage))/100
            frame.size.height = maxHeight
            frame.origin.y = (UIScreen.mainScreen().bounds.height ?? 0) - frame.height
            UIView.animateWithDuration(0.5, animations: {
                self.frame = frame
            })
            self.tableView.scrollEnabled = true
            self.collectionView.scrollEnabled = true
        }
    }
    
    func swipeDownGestureRecognized(sender: AnyObject?) {
        
        // Set min size frame
        var frame = UIScreen.mainScreen().bounds
        let height = (frame.height * actionSheetProperties.minPercentage)/100
        frame.size.height = height
        frame.origin.y = (UIScreen.mainScreen().bounds.height ?? 0) - frame.height
        UIView.animateWithDuration(0.5, animations: {
            self.frame = frame
        })
        self.tableView.scrollEnabled = false
        self.collectionView.scrollEnabled = false
    }
    
    func wholeTableVisible() -> Bool
    {
        // Find the last indexPath
        let lastSection = (actionSheetProperties.headers?.count ?? 1) - 1
        if self.actionSheetProperties.data?.count > lastSection {
            let lastRow = (self.actionSheetProperties.data?[lastSection].count ?? 1) - 1
            let indexPath = NSIndexPath(forRow: lastRow, inSection: lastSection)
            // Check if last row within table view's frame
            if collectionView.hidden == true {
                let cellRect = tableView.rectForRowAtIndexPath(indexPath)
                let completelyVisible = tableView.bounds.contains(cellRect)
                return completelyVisible
            } else {
                if let cellRect = collectionView.layoutAttributesForItemAtIndexPath(indexPath)?.frame {
                    let completelyVisible = collectionView.bounds.contains(cellRect)
                    return completelyVisible
                }
            }
        }
        return true
    }
    
}
