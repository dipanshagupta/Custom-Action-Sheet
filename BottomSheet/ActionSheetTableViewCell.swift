//
//  ActionSheetTableViewCell.swift
//  ActionSheet
//
//  Created by Dipansha on 6/2/16.
//  Copyright © 2016 Dipansha. All rights reserved.
//

import UIKit

class ActionSheetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var optionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.backgroundColor = UIColor.clearColor()
        
        self.bottomLineView.backgroundColor = UIColor.blackColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(text: String?, rowTextColor: UIColor?, rowTextFont: UIFont?)
    {
        optionLabel.text = text
        optionLabel.textColor = rowTextColor
        optionLabel.font = rowTextFont
    }
}
