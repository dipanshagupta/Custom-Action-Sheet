//
//  ActionSheetCollectionViewCell.swift
//  ActionSheet
//
//  Created by Dipansha on 6/2/16.
//  Copyright © 2016 Dipansha. All rights reserved.
//

import UIKit

class ActionSheetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func configureCell(text: String?, rowTextColor: UIColor?, rowTextFont: UIFont?, iconTextFont: UIFont?, iconText: String?, iconTextColor: UIColor?)
    {
        textLabel.text = text
        textLabel.textColor = rowTextColor
        textLabel.font = rowTextFont
        
        iconLabel.text = iconText
        iconLabel.textColor = iconTextColor
        iconLabel.font = iconTextFont
    }

}
