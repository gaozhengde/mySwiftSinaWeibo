//
//  UIColor + Extension.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/30.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

extension UIColor {

    class func randomColor() -> UIColor{

    return UIColor(red: CGFloat(arc4random_uniform(256)) / 255, green: CGFloat(arc4random_uniform(256)) / 255, blue: CGFloat(arc4random_uniform(256)) / 255, alpha: 1)
   
    }
    
}




