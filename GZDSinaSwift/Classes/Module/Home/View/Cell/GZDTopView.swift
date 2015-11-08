//
//  GZDTopView.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/1.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

let statusCellMargin : CGFloat = 8

class GZDTopView: UIView {
    
    //MARK: - 属性 懒加载
    var status :GZDStatus? {
        didSet{
            
            userNameLabel.text = status!.idstr
            
            timeLabel.text = status!.created_at
            sourceLabel.text = status!.source
            //如果有值就加载图片
            if let user:GZDUser = status?.user {
                iconView.gzd_setImageWithURL(NSURL(string:user.profile_image_url!))
                userNameLabel.text = user.name
                
                verifiedView.image = user.verifiedTypeImage
                memberView.image = user.mbrankImage
                
            }
            
            
        }
    }
    //用户头像
    private lazy var iconView :UIImageView = UIImageView()
    //用户名称
    private lazy var userNameLabel :UILabel = UILabel(fontSize: 12, fontColor: UIColor.darkGrayColor())
    //时间名称
    private lazy var timeLabel :UILabel = UILabel(fontSize: 10, fontColor: UIColor.orangeColor())
    //会员等级图片
    private lazy var memberView :UIImageView = UIImageView()
    //  微博来源label
    private lazy var sourceLabel :UILabel = UILabel(fontSize: 10, fontColor: UIColor.grayColor())
    //认证
    private lazy var verifiedView : UIImageView = UIImageView()
    //头部分割线View
    private lazy var topSeparatorLine :UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return lineView
    }()
    
    //MARK: - 构造方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //准备UI
        prepareUI()
    }
    
    private func prepareUI (){
        
        addSubview(iconView)
        addSubview(userNameLabel)
        addSubview(timeLabel)
        addSubview(memberView)
        addSubview(sourceLabel)
        addSubview(verifiedView)
        addSubview(topSeparatorLine)
        //显示数据
        //添加约束
        topSeparatorLine.ff_AlignInner(type: ff_AlignType.TopCenter, referView:self, size: CGSize(width: UIScreen.width(), height: 10))
        
        iconView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topSeparatorLine, size: CGSize(width: 35, height: 35), offset: CGPoint(x: statusCellMargin, y: statusCellMargin))
//        iconView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: self, size:CGSize(width: 25, height: 25), offset: CGPoint(x: statusCellMargin, y: statusCellMargin))
        
        userNameLabel.ff_AlignHorizontal(type: ff_AlignType.TopRight, referView: iconView, size: nil, offset: CGPoint(x: statusCellMargin, y: 0))
        
        timeLabel.ff_AlignHorizontal(type: ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: statusCellMargin, y: 0))
        
        memberView.ff_AlignHorizontal(type: ff_AlignType.TopRight, referView: userNameLabel, size:nil, offset: CGPoint(x: statusCellMargin, y: 0))
        
        sourceLabel.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: timeLabel, size: nil, offset: CGPoint(x: statusCellMargin, y: 0))
        
        verifiedView.ff_AlignInner(type: ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: statusCellMargin, y: statusCellMargin))
        
        
        
        //        iconView.backgroundColor = UIColor.redColor()
        //        userNameLabel.backgroundColor = UIColor.brownColor()
        //        timeLabel.backgroundColor = UIColor.blueColor()
        //        memberView.backgroundColor = UIColor.blackColor()
        //        sourceLabel.backgroundColor = UIColor.orangeColor()
        
        
    }
    
    /*
    /// 微博创建时间
    var created_at: String?
    
    /// 字符串型的微博ID
    var idstr: String?
    
    /// 微博信息内容
    var text: String?
    
    /// 微博来源
    var source: String?
    
    /// 微博的配图
    var pic_urls: [[String: AnyObject]]?
    
    /// 用户模型
    var user : GZDUser?
    /// 字符串型的用户UID
    var idstr : String?
    /// 友好显示名称
    var name : String?
    /// 用户头像地址（中图），50×50像素
    var profile_image_url :String?
    /// verified_type 没有认证:-1   认证用户:0  企业认证:2,3,5  达人:220
    var verified_type: Int = -1
    
    var verifiedTypeImage:UIImage? {
    
    switch verified_type{
    case 0:
    return UIImage(named: "avatar_vip")
    
    case 2,3,5:
    
    return UIImage(named: "avatar_enterprise_vip")
    
    case 220:
    
    return UIImage(named: "avatar_grassroot")
    
    default:
    
    return nil
    
    }
    
    }
    /// 会员等级 1-6
    var mbrank: Int = 0
    
    // 计算型属性,根据不同会员等级返回不同的图片
    var mbrankImage :UIImage?{
    
    
    
    */
    
    
    
    
    
    
}
