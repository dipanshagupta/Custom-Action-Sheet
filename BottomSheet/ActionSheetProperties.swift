//
//  ActionSheetProperties.swift
//  ActionSheet
//
//  Created by Dipansha on 6/3/16.
//  Copyright © 2016 Dipansha. All rights reserved.
//

import Foundation
import UIKit

class ActionSheetProperties {
    
    var type = ActionSheetType.Table
    var titleLabelText: String = "Title"
    var backgroundViewAlphaComponent : CGFloat = 0.4
    var maxPercentage: CGFloat = 70
    var minPercentage: CGFloat = 60
    var headers: [String]?
    var data: [[String]]?
    var icons: [[String]]?
    var cellTextFont : UIFont = UIFont.systemFontOfSize(14)
    var cellTextColor: UIColor = UIColor.darkGrayColor()
    var headerTextFont : UIFont = UIFont.boldSystemFontOfSize(14)
    var headerTextColor: UIColor = UIColor.darkGrayColor()
    var titleTextFont : UIFont = UIFont.boldSystemFontOfSize(14)
    var titleTextColor: UIColor = UIColor.blackColor()
    var iconTextFont : UIFont = UIFont.boldSystemFontOfSize(14)
    var iconTextColor: UIColor = UIColor.blackColor()
    var separatorColor: UIColor = UIColor.grayColor()
    
}