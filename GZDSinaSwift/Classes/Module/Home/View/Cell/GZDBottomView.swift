//
//  GZDBottomView.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/2.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

class GZDBottomView: UIView {

    //MARK: - 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//底下有三个按钮
    //MARK: - 懒加载控件
    //评论按钮
    private let commentButton :UIButton = UIButton(imageName: "timeline_icon_comment", title: "评论", backgroundImageName:
        "timeline_retweet_background")
    //转发
    private let messageButton :UIButton = UIButton(imageName: "timeline_icon_retweet", title: "转发", backgroundImageName:
        "timeline_retweet_background")
    //点赞
    private let likeButton :UIButton = UIButton(imageName: "timeline_icon_unlike", title: "喜欢", backgroundImageName:
        "timeline_retweet_background")
    
    //水平分割线
    
    private let separatorLineOne : UIImageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line"))
    
    private let separatorLineTwo : UIImageView = UIImageView(image: UIImage(named:"timeline_card_bottom_line"))
    
    private func prepareUI() {
        //加载控件
        addSubview(commentButton)
        addSubview(messageButton)
        addSubview(likeButton)
        addSubview(separatorLineOne)
        addSubview(separatorLineTwo)
        
        //设置约束

        //这个方法会将加进去的View 进行平均分
        self.ff_HorizontalTile([messageButton,commentButton,likeButton], insets: UIEdgeInsetsZero)
        separatorLineOne.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: commentButton, size: nil)
        separatorLineTwo.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: messageButton, size: nil)
        
    }

}
