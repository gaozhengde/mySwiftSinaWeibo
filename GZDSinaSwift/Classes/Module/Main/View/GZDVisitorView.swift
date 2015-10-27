//
//  GZDVisitorView.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/26.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

/**
 按钮点击的代理方法
 */
//MARK: - 代理方法
protocol GZDVisitorViewDelegate: NSObjectProtocol{
    
   
        func visitorViewWillRegister()
    
        func visitorViewWillLogin()
        
    }


class GZDVisitorView: UIView {
    
    //代理
    weak var delegate: GZDVisitorViewDelegate?
    
    //MARK: - 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///添加子控件
    func prepareUI(){
        
        
        addSubview(iconView)
        addSubview(coverImageView)
        addSubview(homeView)
        addSubview(titleLable)
        addSubview(registerButton)
        addSubview(loginButton)
        backgroundColor = UIColor(white: 237 / 255, alpha: 1)
    
    }
    
    //MARK: - 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //autoresizeingmask
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        homeView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //轮子的约束
        
        addConstraint( NSLayoutConstraint.init(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -50))
        
//             addConstraint( NSLayoutConstraint.init(item: whellImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem:nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 200))
        //房子View 的frame
        
        addConstraint(NSLayoutConstraint.init(item: homeView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: homeView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
        //label的 约束
        
        addConstraint(NSLayoutConstraint.init(item: titleLable, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))

//        addConstraint(NSLayoutConstraint.init(item: titleLable, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: whellImageView, attribute: NSLayoutAttribute.Left, multiplier: 1
//            , constant: 0))
//
//        addConstraint(NSLayoutConstraint.init(item: titleLable, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: whellImageView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: titleLable, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        
        addConstraint(NSLayoutConstraint.init(item: titleLable, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 240))
        //注册按钮的
        addConstraint(NSLayoutConstraint.init(item: registerButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: titleLable, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: registerButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: titleLable, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        
        addConstraint(NSLayoutConstraint.init(item: registerButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))

        //登录按钮
        
        addConstraint(NSLayoutConstraint.init(item: loginButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: titleLable, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: registerButton, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: loginButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: registerButton, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        
        //遮罩
    
        addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: registerButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        
        
        
        
    }
    
    func setUpSelf(image: String ,message : String){
        
        iconView.image = UIImage(named: image)
        
        titleLable.text = message
        
        homeView.hidden = true
        
        sendSubviewToBack(coverImageView)
    }
    
    //MARK: - 添加核心动画开始旋转
    
    func startRotationAnimation() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = 2 * M_PI
        
        animation.duration = 20
        
        animation.repeatCount = MAXFLOAT
        
        animation.removedOnCompletion = false
        
        iconView.layer.addAnimation(animation, forKey: "homeRotation")
        
    }
    
    //MARK: - 注册按钮和登陆按钮单击时间
    
    func registerButtonClick(){
        
//        print(__FUNCTION__)
        if (delegate?.respondsToSelector("visitorViewWillRegister") != nil){
            delegate?.performSelector("visitorViewWillRegister")
        }
    }
    
    func loginButtonClick(){
    
        if (delegate?.respondsToSelector("visitorViewWillLogin") != nil) {
           delegate?.performSelector("visitorViewWillLogin")
        }
        
    }
//
    //MARK: - 懒加载
    
    lazy var iconView : UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "visitordiscover_feed_image_smallicon")
        
        return imageView
    }()
    
    
    lazy var homeView : UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "visitordiscover_feed_image_house")
        imageView.sizeToFit()
        
        return imageView
    }()
    
    lazy var titleLable : UILabel = {
        
        let templeLabel = UILabel()
        
        templeLabel.text = "关注一些人,看看有什么惊喜,关注一些人,看看有什么惊喜,关注一些人,看看有什么惊喜,关注一些人,看看有什么惊喜"
        
        templeLabel.textColor = UIColor.lightGrayColor()
        
        templeLabel.sizeToFit()
        
        templeLabel.numberOfLines  = 0
        
        return templeLabel
        
    }()
    
    lazy var registerButton : UIButton = {
        
        let button = UIButton(type: UIButtonType.Custom)
        
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        
        button.setTitle("注册", forState: UIControlState.Normal)
        
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
        button.addTarget(self, action: "registerButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }()
    
    
    lazy var loginButton : UIButton = {
        
        let button = UIButton(type: UIButtonType.Custom)
        
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
        button.setTitle("登录", forState: UIControlState.Normal)
        
        button.addTarget(self, action: "loginButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        return button
        
    }()
    
   lazy var coverImageView :UIImageView = {
       
        let imageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        
        return imageView
    }()
    
    
    
    
    
    
    
    
}
