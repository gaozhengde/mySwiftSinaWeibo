//
//  GZDPhotoSelectController.swift
//  照片选择器
//
//  Created by 高正德 on 15/11/7.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit

class GZDPhotoSelectController: UICollectionViewController,GZDPhotoSelectorCellDelegate{
    
    //MARK: - 属性
    //选择的图片 并且初始化
    var photos: [UIImage] = [UIImage]()
    
    //最大的照片张数
    private let maxPhotoCount = 6
    
    //记录点击cell indexPath
    
    var currentIndexPath: NSIndexPath?
    
    private var layout = UICollectionViewFlowLayout()
    
    init() {
        
        super.init(collectionViewLayout:layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        prepareCollectionView()
        
    }
    
    func  prepareCollectionView() {
        
        collectionView?.registerClass(GZDPhotoSelectorCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView?.backgroundColor = UIColor.grayColor()
        
        layout.itemSize = CGSize(width: 80, height: 80)
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //当图片数量小于最大张数的 cell 的数量  = 照片的张数 + 1
        //当图片数量等于最大张数  cell 的数量 = 照片的数量
        
//        return photos.count < maxPhotoCount ? photos.count + 1 : photos.count
        return 6
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! GZDPhotoSelectorCell
        
        cell.cellDelegate = self
        
        cell.backgroundColor = UIColor.brownColor()
        
        //当有图片的时候才设置图片
        
        if indexPath.item < photos.count {
            cell.image = photos[indexPath.item]
        }else{  //设置图片防止cell复用
            cell.setAddButton()
        }
        
            return cell
    }
    
    
    //点击加号代理
    func photoSelectorellAddPhoto(cell : GZDPhotoSelectorCell) {
        
        if !UIImagePickerController.isSourceTypeAvailable( UIImagePickerControllerSourceType.PhotoLibrary){
            print("相册不可用")
            return
        }
        let picker = UIImagePickerController()
        
        presentViewController(picker, animated: true) { () -> Void in
            
        }
    }
    //点击删除代理
    func photoSelectorCellRemovePhoto(cell : GZDPhotoSelectorCell){
        
    }
    
}
//扩展

extension GZDPhotoSelectController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    //选择照片时的代理方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("image \(image)")
        //完成回调
        
        //将选择的图片添加到数组
        photos.append(image)
        //刷新数据
        collectionView?.reloadData()
        //关闭系统相册
        picker.dismissViewControllerAnimated(true) { () -> Void in
            
        }
        
    }
}




protocol GZDPhotoSelectorCellDelegate : NSObjectProtocol{
    
    //点击加号代理
    func photoSelectorellAddPhoto(cell : GZDPhotoSelectorCell)
    //点击删除代理
    func photoSelectorCellRemovePhoto(cell : GZDPhotoSelectorCell)
    
    
}


class GZDPhotoSelectorCell : UICollectionViewCell {
    
    //cell的代理方法
    weak var cellDelegate : GZDPhotoSelectorCellDelegate?
    //image 用来显示
    var image : UIImage? {
        
        didSet{
            
            addButton.setImage(image, forState: UIControlState.Normal)
            addButton.setImage(image, forState: UIControlState.Highlighted)
        }
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - 准备UI
    
    func prepareUI() {
        
        //添加子控件
        contentView.addSubview(addButton)
        contentView.addSubview(removeButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        
        //  设置约束
        let views = ["ab": addButton,"rb" : removeButton]
        
//            addButton.frame = contentView.bounds
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[ab]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[ab]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil,views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[rb]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        contentView.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[rb]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        
    }
    
    //MARK: - 按钮点击事件
    
    func addPhoto () {
        
        cellDelegate?.photoSelectorellAddPhoto(self)
        
    }
    
    func removePhoto() {
        
        cellDelegate?.photoSelectorCellRemovePhoto(self)
    }
    
    func setAddButton() {
        //设置按钮图片
        addButton.setImage(UIImage(named: "compose_pic_add"), forState: UIControlState.Normal)
        addButton.setImage(UIImage(named:"compose_pic_add_highlighted" ), forState: UIControlState.Highlighted)
        
        removeButton.hidden = true
    }
    
    
    //MARK: - 懒加载
    
    private lazy var addButton : UIButton  = {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "compose_pic_add"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "compose_pic_add_highlighted"), forState: UIControlState.Highlighted)
        
        button.addTarget(self, action: "addPhoto", forControlEvents: UIControlEvents.TouchUpInside)
        
        //设置按钮图片的显示模式
        
        button.contentMode = UIViewContentMode.ScaleAspectFill
        
//        button.sizeToFit()
        
        return button
        
    }()
    
    private lazy var removeButton :UIButton = {
        
        let button = UIButton()
//        button.setImage(UIImage(named: "compose_photo_close"), forState: UIControlState.Normal)
        
        button.setBackgroundImage(UIImage(named: "compose_photo_close"), forState: UIControlState.Normal)
//        button.setImage(UIImage(named: "compose_photo_close"), forState: UIControlState.Highlighted)
        
        button.addTarget(self, action: "removePhoto", forControlEvents: UIControlEvents.TouchUpInside)
        button.sizeToFit()
        
        return button
    }()
    
    
    
}



