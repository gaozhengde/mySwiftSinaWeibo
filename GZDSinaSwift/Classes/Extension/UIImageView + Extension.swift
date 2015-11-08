//
//  UIImageView + Extension.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/3.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func gzd_setImageWithURL(url: NSURL!) {
        
        sd_setImageWithURL(url)
    }
    
    func  gzd_setImageWithURL(url: NSURL!, placeholderImage placeholder: UIImage!){
        sd_setImageWithURL(url, placeholderImage: placeholder)
    }
    
}
