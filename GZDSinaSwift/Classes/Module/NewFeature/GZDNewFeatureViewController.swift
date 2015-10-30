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
        
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        cell.backgroundColor = UIColor.randomColor()
    
        return cell
    }
}
