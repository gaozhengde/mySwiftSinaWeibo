//
//  UIScreen + Extension.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/2.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

extension UIScreen {
    
    class  func height() -> CGFloat{
        
        return UIScreen.mainScreen().bounds.height
    }

    class  func width() -> CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    
}
