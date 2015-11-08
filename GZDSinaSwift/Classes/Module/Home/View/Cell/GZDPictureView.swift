
//
//  GZDPictureView.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/2.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit
import SDWebImage
class GZDPictureView: UICollectionView {
    
    //MARK: - 属性
    
    private let statusPictureViewIdentifier = "statusPictureViewIdentifier"
    
    private let layout = UICollectionViewFlowLayout()
    
    var status : GZDStatus?{
        
        didSet{
            //属性监视器
            //刷新数据
            //           bounds.size = calculateViewSize()
            
            reloadData()
        }
    }

    //给出1个方法 来自己设置自己的尺寸
    
    func calculateViewSize () ->CGSize {
        
        let itemSize = CGSize(width: 90, height: 90)
        
        layout.itemSize = itemSize
        
        
        let margin : CGFloat = 10
        
        layout.minimumInteritemSpacing = margin
        layout.minimumLineSpacing = margin
        
        let column = 3
        
        let picCount = status?.urls?.count ?? 0
        
        
        if picCount == 0 {
            return CGSizeZero
        }
        
        //两行两列
        if picCount == 4{
            
        }
        
        //当只有1张图片的时候item的size 和 view 的size是一样大
        if picCount == 1{
            
            let urlString = status?.urls!.first?.absoluteString
            
            var itemSize = CGSize(width: 150, height: 120)
            
            if let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(urlString) {
                
                itemSize = image.size
            }
            if itemSize.width < 40 {
                itemSize.width = 40
            }
            
            
            
            layout.itemSize = itemSize
            
            return itemSize
        }
        
        //如果是4张图片的时候,宽度和高度相等
        if picCount == 4 {
            let width = 2 * itemSize.width + margin
            return CGSize(width: width, height: width)
        }
        
        //其余的张数
        //计算公式  计算行数 公式:行数 = (图片数量 + 列数 - 1)/列数
        
        let row = (picCount + column - 1) / column
        //宽度公式  宽度 = (列数*item的宽度) + (列数-1)*margin
        
        let width  = (CGFloat(column) * itemSize.width) + (CGFloat(column) - 1) * margin
        
        //高度 = (行数 * item的高度) + (行数 - 1) * margin
        
        let height = (CGFloat(row) * itemSize.height) + (CGFloat(row) - 1) * margin
        
        return CGSize(width: width, height: height)
    }
    
    
    
    
    //MARK: - 构造函数
    
    init() {
        //这个地方layout 不能用懒加载, 因为懒加载是用到的时候才去赋值,所以必须要使用属性
        super.init(frame: CGRectZero, collectionViewLayout: layout)
        //设置背景颜色
//        backgroundColor = UIColor.blueColor()
        backgroundColor = UIColor.clearColor()
        dataSource = self

        //注册cell
        registerClass(GZDStatusPictureViewCell.self, forCellWithReuseIdentifier: statusPictureViewIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//数据源方法

extension GZDPictureView: UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return status?.urls?.count ?? 0
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //在init方法里面已经注册了 现在直接去缓存池里面取
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(statusPictureViewIdentifier, forIndexPath: indexPath) as! GZDStatusPictureViewCell

//      let url   = NSURL(string: statuses?.pic_urls?[indexPath.item]["thumbnail_pic"] as! String)
//        
//        cell.imageUrl = url
        cell.imageUrl = status?.urls?[indexPath.item]
        
        return cell
    }
    

   
    
    
    
    
    
}
//自定义cell 用来显示图片

class GZDStatusPictureViewCell :UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareUI (){
        
        contentView.addSubview(iconView)
        
        //添加约束
        
        iconView.ff_Fill(contentView)
    }
    
       //MARK: - 属性
    
    var imageUrl : NSURL?{
        
        didSet{
            //加载图片
            iconView.gzd_setImageWithURL(imageUrl)
        }
        
    }
    
    private lazy var iconView :UIImageView = {
       
        let imageView = UIImageView()
        //裁切模式  填充 等里拉伸
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
}


