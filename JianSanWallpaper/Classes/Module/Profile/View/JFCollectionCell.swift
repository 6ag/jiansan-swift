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

    @IBOutlet weak var wallpaperImageView: UIImageView!

    var bigpath: String? {
        didSet {
            wallpaperImageView.setImage(urlString: "\(BASE_URL)/\(bigpath ?? "")", placeholderImage: nil)
        }
    }
}
