//
//  UIButton + Extension.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/2.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(imageName:String,title:String,backgroundImageName:String,fontSize:CGFloat = 12 ,fontColor : UIColor = UIColor.darkGrayColor()) {
    
        self.init()
    
    //设置文字
        setTitle(title, forState: UIControlState.Normal)
    //设置文字颜色
        setTitleColor(fontColor, forState: UIControlState.Normal)
     //设置文字大小
       titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    
    //设置图片
       setImage(UIImage(named: imageName), forState: UIControlState.Normal)
    //设置背景图片
       setBackgroundImage(UIImage(named: backgroundImageName), forState: UIControlState.Normal)
    }
    
    
}
