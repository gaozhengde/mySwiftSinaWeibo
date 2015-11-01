//
//  GZDWelcomeViewController.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/30.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit
import SDWebImage

class GZDWelcomeViewController: UIViewController {
    
    
    private var iconViewVConstraint : NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        
        //加载用户头像
        
        if let urlString = GZDUserAccount.loadAccount()?.avatar_large{
            
            iconView.sd_setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "avatar_default_big"))
        }
        
    }
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //改变自动布局约束的值
        //有弹性效果的 动画
        self.iconViewVConstraint!.constant = -(self.view.bounds.size.height - 160 )
        UIView.animateWithDuration(2, delay:0.1, usingSpringWithDamping:0.6, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
        
            self.view.layoutIfNeeded()
            
            }) { (_) -> Void in
                //动画完成回调
                UIView.animateWithDuration(1, animations: { () -> Void in
                    
                    self.welcomeLabel.alpha = 1
                    
                    
                    }, completion: { (_) -> Void in
                        //文字动画完成回调
                        (UIApplication.sharedApplication().delegate as! AppDelegate).switchController(true)
                })
                
        }
    }
    
    //懒加载
    private lazy var backgroundView :UIImageView = {
        let imageView = UIImageView(image: UIImage(named:"ad_background"))
        return imageView
    }()
    private lazy var iconView :UIImageView = {
        
        let imageView = UIImageView(image: UIImage(named: "avatar_default_big"))
        imageView.layer.cornerRadius = 42.5
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    private lazy var welcomeLabel :UILabel = {
        
        let label = UILabel()
        
        label.text = "欢迎归来"
        
        label.alpha = 0
        
        return label
    }()
    
    ///准备UI
    //添加子控件
    //添加约束
    private func prepareUI() {
        
        view .addSubview(backgroundView)
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //        backgroundView.frame = view.bounds
        
        //添加约束
        //backgroundView的约束
        //使用VFL 添加约束 H  V
        //水平方向
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bkg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bkg" : backgroundView]))
//        
//        //垂直方向
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[bkg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bkg" : backgroundView]))
        
        //使用第三方框架修改约束
        
        backgroundView.ff_Fill(view)
        
        
        //头像的约束
        //底部距离父控件底部-160
        
//        iconViewVConstraint = NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -160)
//        
//        view.addConstraint(iconViewVConstraint!)
//        
//        //水平居中
//        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
//        
//        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 85))
//        
//          view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 85))
        
     let iconViewConstrains = iconView.ff_AlignInner(type: ff_AlignType.BottomCenter, referView: view, size: CGSize(width: 85, height: 85), offset: CGPoint(x: 0, y: -160))
        

        //要拿到底部相对于父控件的约束
        
      iconViewVConstraint = iconView.ff_Constraint(iconViewConstrains, attribute: NSLayoutAttribute.Bottom)
        
        
        //欢迎文字的约束
        
//        view.addConstraint(NSLayoutConstraint(item: welcomeLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
//        
//        view.addConstraint(NSLayoutConstraint(item: welcomeLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 20))
        
        welcomeLabel.ff_AlignVertical(type: ff_AlignType.BottomCenter, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 20))
        
        
        
    }
    
    
}
