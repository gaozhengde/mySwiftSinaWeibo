//
//  GZDTabBar.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/26.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

class GZDTabBar: UITabBar {

    private let count : CGFloat = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(composeButton)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        let width = bounds.width / count
        
        let height = bounds.height
        
        let frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        
        var index = 0
        
        for view in subviews{
//            print("view = \(view)")
//            
//            print("--------------")
            if view is UIControl && !(view is UIButton){
                
                view.frame = CGRectOffset(frame,CGFloat(index) * width, 0)
                
                
                
                index += index == 1 ? 2 : 1
            }
            
        }
        
        composeButton.frame = CGRectOffset(frame, width * 2, 0)
    }
   
    
   lazy var composeButton : UIButton = {
    
    let templeButton = UIButton(type: UIButtonType.Custom)
    templeButton.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
    templeButton.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
    templeButton.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
    templeButton.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
    templeButton.addTarget(self, action: "composeButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
    
    return templeButton
    
    }()
    
    func composeButtonClick (){
        print("composeButtonClick")
    }
    
    
    
    

}
