//
//  UIBarButtonItem + Extension.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/31.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit


//扩展

extension UIBarButtonItem {
    

    convenience init(imageName: String) {
        
        let button = UIButton(type: UIButtonType.Custom)
        
        button.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
        
        button.setBackgroundImage(UIImage(named: "\(imageName)_highlighted"), forState: UIControlState.Highlighted)
        
        button.sizeToFit()

        self.init(customView: button)
    }
    
    convenience init(imageName:String ,target:AnyObject,selector: Selector){
        
        let button = UIButton(type: UIButtonType.Custom)
        button.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
       
        button.addTarget(target, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        button.sizeToFit()
        
        self.init(customView: button)
    }
    
    
    
//     func setUpNavigationItem (imageName : String) ->UIBarButtonItem{
//        
//        let button = UIButton(type: UIButtonType.Custom)
//        
//        button.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
//        
//        button.setBackgroundImage(UIImage(named: "\(imageName)_highlighted"), forState: UIControlState.Highlighted)
//        button.sizeToFit()
//        
//        return UIBarButtonItem(customView: button)
//    }
    
    
    
    
    
}