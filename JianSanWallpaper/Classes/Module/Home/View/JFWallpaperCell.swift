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
    
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var viewLabel: UILabel!
    
    var model: JFWallPaperModel? {
        didSet {
            wallpaperImageView.setImage(urlString: "\(BASE_URL)/\(model?.smallpath ?? "")", placeholderImage: UIImage(named: "placeholder"))
            viewLabel.text = "\(model?.view ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 离屏渲染 - 异步绘制
        layer.drawsAsynchronously = true
        
        // 栅格化 - 异步绘制之后，会生成一张独立的图像，cell在屏幕上滚动的时候，本质滚动的是这张图片
        layer.shouldRasterize = true
        
        // 使用栅格化，需要指定分辨率
        layer.rasterizationScale = UIScreen.main.scale
    }
}
