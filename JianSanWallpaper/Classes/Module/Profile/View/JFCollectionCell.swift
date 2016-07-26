//
//  JFCollectionCell.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/26.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import YYWebImage

class JFCollectionCell: UICollectionViewCell {

    var bigpath: String? {
        didSet {
            wallpaperImageView.yy_setImageWithURL(NSURL(string: "\(BASE_URL)/\(bigpath!)"), placeholder: nil, options: YYWebImageOptions.Progressive, completion: nil)
        }
    }
    
    @IBOutlet weak var wallpaperImageView: UIImageView!

}
