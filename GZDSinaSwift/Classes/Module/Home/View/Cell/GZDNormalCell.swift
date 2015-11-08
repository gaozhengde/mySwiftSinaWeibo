//
//  GZDNormalCell.swift
//  GZDSinaSwift
//
//  Created by 高正德 on 15/11/2.
//  Copyright © 2015年 高正德. All rights reserved.
//

import UIKit
//原创cell
class GZDNormalCell: GZDHomeCell {

    override func prepareUI() {
        super.prepareUI()
              let constraints = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: statusCellMargin))
        
              pictureViewHeigthConstraint = pictureView.ff_Constraint(constraints, attribute: NSLayoutAttribute.Height)
                pictureViewWidthConstraint = pictureView.ff_Constraint(constraints, attribute: NSLayoutAttribute.Width)
    }

}
