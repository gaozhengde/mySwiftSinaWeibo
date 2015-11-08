//
//  GZDComposeViewController.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/5.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit
import SVProgressHUD
class GZDComposeViewController: UIViewController{
    
    //toolBar 底部约束
    var toolBarBottomConstrain : NSLayoutConstraint?
    //照片选择器控制器view的底部的约束
    
    private var photoSelectorViewBottomConstrain: NSLayoutConstraint?
    
    private let statusMaxLength = 20
    //照片选择器的控制器
    private lazy var photoSelectorVC : GZDPhotoSelectController = {
        let controller = GZDPhotoSelectController()
        //让照片选择控制器被人管理

       self.addChildViewController(controller)
        
        return controller
    }()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//弹出键盘就是让view 成为第一响应者
        
        //如果照片选择器的view 没有显示就弹出键盘
        if photoSelectorViewBottomConstrain?.constant != 0 {
            textView.becomeFirstResponder()
            
        }
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
      
        //添加键盘frame改变的通知
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
  
 
    }
deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    //监听键盘frame的改变
    func willChangeFrame(notification:NSNotification) {
        
        let endFrame = notification.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        
        toolBarBottomConstrain?.constant = -(UIScreen.height() - endFrame!.origin.y)
        
        photoSelectorViewBottomConstrain?.constant = photoSelectorVC.view.bounds.height
        
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
//如果照片选择器的view 没有显示就弹出键盘
        if photoSelectorViewBottomConstrain?.constant != 0 {
            textView.becomeFirstResponder()
        }
        
        
    }
    
    
    
    
    private func prepareUI() {
        view.addSubview(textView)
        view.addSubview(photoSelectorVC.view)
        view.addSubview(toolBar)
        view.backgroundColor = UIColor.whiteColor()
        
        setupNavigationBar()
        
        setupTitleview()
       
        preparePhotoSelectorView()
        let toolBarConstrains = toolBar.ff_AlignInner(type: ff_AlignType.BottomRight, referView: view, size: CGSize(width: UIScreen.width(), height: 49))
        
        toolBarBottomConstrain = toolBar.ff_Constraint(toolBarConstrains, attribute: NSLayoutAttribute.Bottom)

        textView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: view, size:nil)
        textView.ff_AlignVertical(type: ff_AlignType.TopRight, referView: toolBar, size: nil)
}
    
    
    func preparePhotoSelectorView() {
        //照片选择器控制器的view
        
        let photoSelectorView = photoSelectorVC.view
        
        photoSelectorView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["psv" : photoSelectorView]
        
        //添加约束
        
        //水平方向
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[psv]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        //高度按照比例来计算
        
        view.addConstraint(NSLayoutConstraint(item: photoSelectorView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Height, multiplier: 0.6, constant: 0))
        //底部重合 向下偏移 photoSelectorView 的高度
        
     photoSelectorViewBottomConstrain = NSLayoutConstraint(item: photoSelectorView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: photoSelectorView.bounds.height)
        
        view.addConstraint(photoSelectorViewBottomConstrain!)
        
    }
    
    
    

    
    //按钮点击事件未添加
    private lazy var toolBar : UIToolbar = {
        
        let toolbar = UIToolbar()
        
        let pictureItem = UIBarButtonItem(imageName: "compose_toolbar_picture", target: self, selector: "picture")
        let trendItem = UIBarButtonItem(imageName: "compose_trendbutton_background", target: self, selector: "trend")
        
        let mentionItem = UIBarButtonItem(imageName: "compose_mentionbutton_background", target: self, selector: "mention")
        let emoticonItem = UIBarButtonItem(imageName: "compose_emoticonbutton_background", target: self, selector: "emoticon")
        
        let addImage = UIImage(named: "compose_addbutton_background")
        UIImageResizingMode.Stretch
        let addItem = UIBarButtonItem(imageName: "compose_addbutton_background", target: self, selector: "add")
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([pictureItem,flexibleItem,trendItem,flexibleItem,mentionItem,flexibleItem,emoticonItem,flexibleItem,addItem], animated: true)
        
        toolbar.barTintColor = UIColor(white: 0.9, alpha: 1)
        
        return toolbar
        
    }()
    
    func picture (){
//        print(__FUNCTION__)
        
        //退下键盘
        textView.resignFirstResponder()
        
        
        photoSelectorViewBottomConstrain?.constant = 0
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
        
        
    }
    func trend (){
        print(__FUNCTION__)
    }
    func mention (){
        print(__FUNCTION__)
    }
    func emoticon (){
        print(__FUNCTION__)
    }
    func add (){
        print(__FUNCTION__)
    }
    
    private func setupNavigationBar () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancel")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Plain, target: self, action: "send")
        //中间的lable
        navigationItem.rightBarButtonItem?.enabled = false
    }
    
    private func setupTitleview (){
        
        //一个label搞定
        let prefix : String = "发微博"
        let label = UILabel()
        //设置1个总的大小
        label.font = UIFont.systemFontOfSize(16)
        //可选绑定一下
        if let name = GZDUserAccount.loadAccount()?.name {
            let titleString = prefix + "\n" + name
            
            let attributestring = NSMutableAttributedString(string: titleString)
            
            let range = (titleString as NSString).rangeOfString(name)
            print("\(range)")
            attributestring.addAttributes([NSForegroundColorAttributeName:UIColor.lightGrayColor(),NSFontAttributeName:UIFont.systemFontOfSize(12)], range: range)
            label.attributedText = attributestring
            //添加到titleView 中
            label.textAlignment = NSTextAlignment.Center
            label.numberOfLines = 0
            label.sizeToFit()
            navigationItem.titleView = label
        }else{
            //就是没有值
            navigationItem.title = prefix
        }
        
    }
    //MARK: - navigationItem点击事件
    @objc private func cancel () {
        //关闭键盘
        
        //失去第一响应者
        textView.resignFirstResponder()
        //关闭SV提示

        
        dismissViewControllerAnimated(true) { () -> Void in
            //完成回调
        }
    }
    @objc private func send() {
        
        print(__FUNCTION__)
    }
    
    //懒加载label
    
    private let centerLabel :UILabel = {
        
        let label = UILabel()
        
        return label
    }()
    
    private lazy var textView : GZDPlaceholderTextView = {
       
        let textview = GZDPlaceholderTextView()
        
        textview.placeholder = "分享新鲜事"
        
//       textview.placeholderLabel.ff_AlignInner(type: ff_AlignType.TopLeft, referView: self, size: nil, offset: CGPoint(x: 5, y: 8))
        
        textview.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        textview.font = UIFont.systemFontOfSize(18)
        
        textview.alwaysBounceVertical = true

//        textview.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)

        textview.delegate = self
        
        return textview
    }()

    
}

extension GZDComposeViewController :UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
    
}
