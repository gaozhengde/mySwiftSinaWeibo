//
//  GZDRefreshControl.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/3.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

class GZDRefreshControl : UIRefreshControl {

    //箭头旋转的值
    
    private let RefreshControlOffset :CGFloat = -60
    //重写frame 属性 使用属性监视器来监听他自己的frame 的改变
    
    //标记用户去除重复的打印
    private var isUp = false
    
   override var frame :CGRect {
    didSet{
        //大于0直接返回回去
        if frame.origin.y >= 0 {
            return
        }
        
        if refreshing {
            
         refreshView.startLoading()
        }
        
        
        
        if frame.origin.y < RefreshControlOffset && !isUp{
            print("箭头转上去")
            isUp = true
            refreshView.rotateTipIcon(isUp)
        }
        else if frame.origin.y > RefreshControlOffset && isUp{
            print("箭头转下去")
            isUp = false
            refreshView.rotateTipIcon(isUp)
        }
        
        
        print("frame = \(frame.origin.y)")
    }
}
    
    
    //构造函数里面添加自定义控件
    override init() {
        super.init()
        prepareUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //准备UI
   private  func prepareUI() {
      addSubview(refreshView)
    
    refreshView.ff_AlignInner(type: ff_AlignType.CenterCenter, referView: self, size: refreshView.bounds.size)
        
    }
    
    
    //重写父类停止刷新方法

    override func endRefreshing() {
        super.endRefreshing()
        refreshView.stopAnimation()
        
    }
    
    //懒加载 GZDRefreshView
    
    private lazy var refreshView :GZDRefreshView = GZDRefreshView.refreshView()
    
}

class GZDRefreshView : UIView {
    

    

    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var loadingView: UIImageView!
    @IBOutlet weak var tipIconView: UIImageView!
    class func refreshView () -> GZDRefreshView {
        
 return NSBundle.mainBundle().loadNibNamed("GZDRefreshView", owner: nil, options: nil).last as! GZDRefreshView
    }
    
    ///箭头旋转动画, true  朝上
    ///false 表示朝下
    
    func rotateTipIcon(isUp:Bool) {
        
        UIView.animateWithDuration(0.25) { () -> Void in
self.tipIconView.transform = isUp ? CGAffineTransformMakeRotation(CGFloat(M_PI-0.01)) : CGAffineTransformIdentity
            
        }
     
    }
    func startLoading() {
        
        let animKey = "animKey"
        if let _ = loadingView.layer.animationForKey(animKey){
            //在这边就是找到了 就直接返回掉
            return
        }
        tipView.hidden = true
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = M_PI*2
        anim.duration = 0.25
        anim.repeatCount = MAXFLOAT
        anim.removedOnCompletion = false
        //如果有名称 会先移除掉之前的动画 再重新开始新的动画
        
        loadingView.layer.addAnimation(anim, forKey: animKey)
    }
    
    func stopAnimation(){
        
        tipView.hidden = false
        
        loadingView.layer.removeAllAnimations()
    }
    
    
    
}

