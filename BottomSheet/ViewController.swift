//
//  ViewController.swift
//  BottomSheet
//
//  Created by Dipansha on 10/13/16.
//  Copyright © 2016 Dipansha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func showTableBottomSheet(sender: AnyObject) {
        
        // Display custom sheet
        let customSheet = CustomActionSheet(rootController: self)
        customSheet.actionSheetProperties.type = ActionSheetType.Table
        customSheet.actionSheetProperties.data = [["Apple", "Bananas", "Lichi", "Oranges", "Strawberries", "Guava", "Grapes", "Pomegranate"],["Potato", "Tomato", "Brinjal", "Lady Finger", "Onions"]]
        customSheet.actionSheetProperties.headers = ["Fruits", "Vegetables"]
        customSheet.actionSheetProperties.minPercentage = 30
        customSheet.actionSheetProperties.maxPercentage = 70
        customSheet.actionSheetProperties.titleLabelText = "This is the title"
        customSheet.addSheet({(title: String!, section: Int) -> Void in
            customSheet.hideSheet()
        })
        
        
    }
    
    @IBAction func showCollectionBottomSheet(sender: AnyObject) {
        
        // Display custom sheet
        let customSheet = CustomActionSheet(rootController: self)
        customSheet.actionSheetProperties.type = ActionSheetType.Collection
        customSheet.actionSheetProperties.data = [["Google", "Facebook"],["Skype", "Linkedin"]]
        customSheet.actionSheetProperties.headers = ["Social 1", "Social 2"]
        customSheet.actionSheetProperties.iconTextFont = UIFont(name: "customFont", size: 14) ?? UIFont()
        customSheet.actionSheetProperties.icons = [["\u{f0d5}", "\u{f230}"], ["\u{f17e}", "\u{f0e1}"]]
        customSheet.actionSheetProperties.minPercentage = 30
        customSheet.actionSheetProperties.maxPercentage = 40
        customSheet.actionSheetProperties.titleLabelText = "This is the title"
        customSheet.addSheet({(title: String!, section: Int) -> Void in
            customSheet.hideSheet()
        })
    }
    

}

