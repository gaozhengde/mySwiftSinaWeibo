//
//  GZDForwardCell.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/2.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

class GZDForwardCell: GZDHomeCell {
    
    
  override var status :GZDStatus? {

        didSet{
            
            //给forwardlabel赋值
            let name = status?.retweeted_status?.user?.name ?? "名称为空"
            
            let content = status?.retweeted_status?.text ?? "内容为空"

            forwardLabel.text = "@\(name):\(content)"
            
        }
    }
    //文字label
    private lazy var forwardLabel : UILabel = {
        
        let label = UILabel()
        
//        label.text = "我是测试文字,我是测试文字,我是测试文字,我是测试文字,我是测试文字,我是测试文字,"
        
        label.font = UIFont.systemFontOfSize(12)
        //lable 随机色
        label.textColor = UIColor.randomColor()
        //换行
        label.numberOfLines = 0
        
        return label
    }()
    //背景button
    private lazy var backgroundButton : UIButton = {
        
        let button = UIButton()
        //随机色
        button.backgroundColor = UIColor.randomColor()
        
        return button
    }()
    
    //重写父类方法 添加子控件
    override func prepareUI() {
        
        //调用父类布局
        
        super.prepareUI()
        
      
        //添加背景button
        contentView.insertSubview(backgroundButton, belowSubview: pictureView)
          //添加 转发label
        contentView.addSubview(forwardLabel)
        //设置约束
        //forwardlabel的约束
        
        backgroundButton.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: nil, offset: CGPoint(x:-statusCellMargin, y: statusCellMargin))
        
   backgroundButton.ff_AlignVertical(type: ff_AlignType.TopRight, referView: bottomView, size: nil)
        
        
        //转发label的约束
        forwardLabel.ff_AlignInner(type: ff_AlignType.TopLeft, referView: backgroundButton, size: nil, offset: CGPoint(x: statusCellMargin, y: statusCellMargin))
        
      contentView.addConstraint(NSLayoutConstraint(item: forwardLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: UIScreen.width()-2 * statusCellMargin))
        
              let constraints = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: forwardLabel, size:      CGSizeZero, offset: CGPoint(x: 0, y: statusCellMargin))
        
              pictureViewHeigthConstraint = pictureView.ff_Constraint(constraints, attribute: NSLayoutAttribute.Height)
                pictureViewWidthConstraint = pictureView.ff_Constraint(constraints, attribute: NSLayoutAttribute.Width)
        
    }
    
    
    
}
