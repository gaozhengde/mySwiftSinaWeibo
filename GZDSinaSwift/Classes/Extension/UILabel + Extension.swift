//
//  UILabel + Extension.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/1.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

extension UILabel {
    
    
    convenience init(fontSize : CGFloat , fontColor : UIColor) {
        self.init()
    
        self.font = UIFont.systemFontOfSize(fontSize)
        self.textColor = fontColor
        
    }
    
    
    
}
