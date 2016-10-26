//
//  BackgroundView.swift
//  ActionSheet
//
//  Created by Dipansha on 6/6/16.
//  Copyright © 2016 Dipansha. All rights reserved.
//

import UIKit

class BackgroundView: UIView {

    var containerClass : CustomActionSheet?
    
    func createView(backgroundViewAlphaComponent: CGFloat, container: CustomActionSheet) {
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(backgroundViewAlphaComponent)
        self.frame = UIScreen.mainScreen().bounds
        self.containerClass = container
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BackgroundView.tapGesture)))
    }
    
    func tapGesture()
    {
        self.containerClass?.hideSheet()
    }

}
