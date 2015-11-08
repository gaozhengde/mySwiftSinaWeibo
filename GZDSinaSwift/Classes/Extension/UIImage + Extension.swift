//
//  UIImage + Extension.swift
//  照片选择器
//
//  Created by 高正德 on 15/11/7.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

extension UIImage {
    /*
    等比例缩小 缩小宽度等于300
    return 缩小的图片
    */
    
    func scaleImage() -> UIImage {
        let newWidth : CGFloat = 300
        //图片宽度本来就小于300
        
        if size.width < newWidth {
            
            return self
        }
      //等比例缩放
    
        //newHeight / newWidth = 原来的高度 / 原来的宽度
        
        let newHeight = newWidth * size.height / size.width
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        //准备图形上下文
        
        UIGraphicsBeginImageContext(newSize)
        
        //将当前图片绘制到rect上面
        drawInRect(CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        //从上下文获取绘制好的图片
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //关闭上下文
        
        UIGraphicsEndImageContext()
        
            return newImage
        
        }
    
    
}