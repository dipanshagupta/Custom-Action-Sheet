//
//  CustomActionSheet.swift
//  ActionSheet
//
//  Created by Dipansha on 6/2/16.
//  Copyright © 2016 Dipansha. All rights reserved.
//

import Foundation
import UIKit

class CustomActionSheet {
    
    var rootController : UIViewController?
    var backgroundView : BackgroundView?
    var foregroundView : ActionSheetView?
    var hideSelector: Selector?
    var actionSheetProperties : ActionSheetProperties = ActionSheetProperties()
    
    init(rootController: UIViewController?) {
        self.rootController = rootController
        
        let nibViews1 = NSBundle.mainBundle().loadNibNamed("ActionSheetView", owner: nil, options: nil)
        foregroundView = nibViews1.last as? ActionSheetView
        foregroundView?.backgroundColor = UIColor.whiteColor()
        backgroundView = BackgroundView()
        
    }
    
    func addSheet(selectionHandler: ((String, Int) -> Void)?)
    {
        self.rootController?.navigationController?.navigationBar.userInteractionEnabled = false
        backgroundView?.createView(actionSheetProperties.backgroundViewAlphaComponent, container: self)
        foregroundView?.createView(actionSheetProperties, selectionHandler: selectionHandler)
        if foregroundView != nil && backgroundView != nil  {
            
            let transition:CATransition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromTop
            self.foregroundView?.layer.addAnimation(transition, forKey: kCATransition)
            UIApplication.sharedApplication().keyWindow?.addSubview(self.backgroundView!)
            UIApplication.sharedApplication().keyWindow?.addSubview(self.foregroundView!)
            UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(self.backgroundView!)
            UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(self.foregroundView!)
            
            
        }
        
    }
    
    func hideSheet()
    {
        self.rootController?.navigationController?.view.userInteractionEnabled = true
        self.foregroundView?.removeFromSuperview()
        self.backgroundView?.removeFromSuperview()
    }
    
}