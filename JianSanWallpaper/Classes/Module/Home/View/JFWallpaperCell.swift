//
//  JFWallpaperCell.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/7/25.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import YYWebImage

class JFWallpaperCell: UICollectionViewCell {
    
    var model: JFWallPaperModel? {
        didSet {
            wallpaperImageView.yy_setImageWithURL(NSURL(string: "\(BASE_URL)/\(model!.smallpath!)"), placeholder: UIImage(named: "placeholder"), options: YYWebImageOptions.Progressive, completion: nil)
            viewLabel.text = "\(model!.view)"
        }
    }
    
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var viewLabel: UILabel!
    
}
