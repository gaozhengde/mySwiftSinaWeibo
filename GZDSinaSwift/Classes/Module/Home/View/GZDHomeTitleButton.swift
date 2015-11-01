//
//  GZDHomeTitleButton.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/31.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

class GZDHomeTitleButton: UIButton {


    override func layoutSubviews() {
        super.layoutSubviews()
        
        //改变 titlelabel 和imageView 的 frame 值
        
        titleLabel?.frame.origin.x = 0
        
        imageView?.frame.origin.x = (titleLabel?.frame.width)! + 3
        
    }

}
