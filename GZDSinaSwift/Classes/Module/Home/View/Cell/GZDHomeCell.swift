//
//  GZDHomeCell.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/1.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

class GZDHomeCell: UITableViewCell {
    
    
    private lazy var topView : GZDTopView = GZDTopView()
            lazy var bottomView : GZDBottomView = GZDBottomView()
    var pictureViewHeigthConstraint : NSLayoutConstraint?
     var pictureViewWidthConstraint : NSLayoutConstraint?
    
      lazy var contentLabel : UILabel = {
        
        let label = UILabel()
        
        label.textColor = UIColor.darkGrayColor()
        
        label.numberOfLines = 0
        
        label.font = UIFont.systemFontOfSize(12)
        
        return label
    }()
    
    lazy var pictureView : GZDPictureView = GZDPictureView()
    
    
    var status : GZDStatus? {
        
        didSet{
            //给topview 赋值
            topView.status = status
            contentLabel.text = status?.text
            
            pictureView.status = status
            
            let sizes = pictureView.calculateViewSize()
            
//            print("\(sizes)")
//            重新计算pictureView的约束的值
            pictureViewHeigthConstraint?.constant = sizes.height
            pictureViewWidthConstraint?.constant  = sizes.width
        }
    }
    
    //MARK: - 构造方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //准备UI
        prepareUI()
    }
    
    //准备UI
     func prepareUI() {
        
        //添加子控件
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(pictureView)
        contentView.addSubview(bottomView)
        //设置约束
        topView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: contentView, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 56))
        
        contentLabel.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPoint(x: statusCellMargin, y: statusCellMargin))
        
        contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -statusCellMargin))
        
//      let constraints = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: statusCellMargin))
//        
//      pictureViewHeigthConstraint = pictureView.ff_Constraint(constraints, attribute: NSLayoutAttribute.Height)
//        pictureViewWidthConstraint = pictureView.ff_Constraint(constraints, attribute: NSLayoutAttribute.Width)
//        
        bottomView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: pictureView, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 44), offset: CGPoint(x: -statusCellMargin, y: 8))
        
//        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: bottomView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))

    }
    
    func rowHeight(status:GZDStatus) -> CGFloat {
        
        self.status = status
        
        //更新约束
        
        layoutIfNeeded()
        
        //获取子控件的最大的Y值
        
        let maxY = CGRectGetMaxY(bottomView.frame)
              
        return maxY
        
    }
    
    
    
}
