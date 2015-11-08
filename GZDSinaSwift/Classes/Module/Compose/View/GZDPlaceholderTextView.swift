//
//  GZDPlaceholderTextView.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/5.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

class GZDPlaceholderTextView: UITextView {

    
    //MARK: - 属性
    var placeholder : String? {
        didSet{
            placeholderLabel.text = placeholder
            
            placeholderLabel.font = font
            
            placeholderLabel.sizeToFit()
        }
    }
    
    //MARK: - 构造函数
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        prepareUI()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: UITextViewTextDidChangeNotification, object: self)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //移除通知
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func textDidChange() {
        
        placeholderLabel.hidden = hasText()
        
    }
    
    private func prepareUI(){
        
        addSubview(placeholderLabel)
        
        placeholderLabel.ff_AlignInner(type: ff_AlignType.TopLeft, referView: self, size: nil, offset: CGPoint(x: 5, y: 8))


    }
    
    
    //懒加载
    //添加占位为本
    
    private lazy var placeholderLabel :UILabel = {
       
        let label = UILabel(fontSize: 18, fontColor: UIColor.lightGrayColor())
        
        return label
    }()
    
}
    