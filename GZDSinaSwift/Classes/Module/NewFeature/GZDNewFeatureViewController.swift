//
//  GZDNewFeatureViewController.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/10/30.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GZDNewFeatureViewController: UICollectionViewController {

    //新特性界面的封面的个数
    private let itemCount = 4
    //声明layout
    private var layout = UICollectionViewFlowLayout()
    
    init(){
        
        super.init(collectionViewLayout:layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.registerClass(GZDCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        prepareLayout()
        
    }

    //MARK: 设置layout的参数
    
    func prepareLayout() {
        //设置item的大小
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        //滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
            //分页
        collectionView?.pagingEnabled = true
        //取消弹簧效果
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
      
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return itemCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GZDCollectionViewCell
    
//        cell.backgroundColor = UIColor.randomColor()
        
            cell.imageIndex = indexPath.item
        
//            cell.startButtonAnimation()
        
        return cell
    }
    //在cell 停止显示的  就是已经显示完成的时候调用
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
            //拿到当前正在显示的item 的indexPath
        let showIndexPath :NSIndexPath = collectionView.indexPathsForVisibleItems().first!
        let cell = collectionView.cellForItemAtIndexPath(showIndexPath) as! GZDCollectionViewCell
        
        if showIndexPath.item == itemCount - 1{

            cell.startButton.hidden = false
            cell.startButtonAnimation()
        }
        
    }
    
    
}

class GZDCollectionViewCell :UICollectionViewCell {
    
    //要知道是第几张 然后设置 图片
    
    var imageIndex :Int = 0 {
        
        didSet{
            backView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
            
            startButton.hidden = true
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareUI()
    }

    private func prepareUI()    {
        
        contentView.addSubview(backView)
        contentView.addSubview(startButton)
        
        //添加约束
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
//    backView.frame = contentView.bounds
        contentView.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[bkg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bkg" :backView]))
        contentView.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bkg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bkg" :backView]))
        
            contentView.addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -160))
        
            contentView.addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))

        
    }
    
    //动画效果的 方法
    
    func startButtonAnimation() {
        startButton.transform = CGAffineTransformMakeScale(0, 0)
        
        UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            
           self.startButton.transform = CGAffineTransformIdentity
            
            }) { (_) -> Void in
                
        }
    }
    
    
    
    
    lazy var backView : UIImageView = UIImageView()
    
    private lazy var startButton :UIButton = {
       
        let button = UIButton()
        
       button.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
         button.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        
        button.setTitle("开始微博", forState: UIControlState.Normal)

        return button
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






