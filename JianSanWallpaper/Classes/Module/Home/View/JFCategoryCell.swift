//
//  JFCategoryCell.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/25.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFCategoryCell: UICollectionViewCell {
    
    var model: JFCategoryModel? {
        didSet {
            categoryImageView.image = UIImage(named: "category_\(model!.alias!)")
        }
    }
    
    @IBOutlet weak var categoryImageView: UIImageView!

}
