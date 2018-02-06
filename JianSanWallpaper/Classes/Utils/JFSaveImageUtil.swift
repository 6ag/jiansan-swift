//
//  JFSaveImageUtil.swift
//  NoCard
//
//  Created by zhoujianfeng on 2017/10/30.
//  Copyright © 2017年 zhoujianfeng. All rights reserved.
//

import UIKit
import Photos

/// 保存图片工具类
class JFSaveImageUtil: NSObject {
    
    /// 需要保存的图片
    fileprivate var image: UIImage
    
    init(image: UIImage) {
        self.image = image
        super.init()
    }
    
    /// 保存图片到相册
    ///
    /// - Parameter image: 图片对象
    func save() {
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            // 获取相册访问权限 子线程回调，所以需要回主线程
            PHPhotoLibrary.requestAuthorization({ (status) in
                DispatchQueue.main.async {
                    self.checkStatus(status: status)
                }
            })
        } else {
            checkStatus(status: PHPhotoLibrary.authorizationStatus())
        }
    }
    
    /// 检查授权
    ///
    /// - Parameters:
    ///   - status: 授权状态
    ///   - image: 图片对象
    fileprivate func checkStatus(status: PHAuthorizationStatus)  {
        switch status {
        case .authorized:
            // 应该是模拟器需要转换才能保存？
            if let ciImage = image.ciImage {
                let context = CIContext()
                if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
                    let uiImage = UIImage(cgImage: cgImage)
                    UIImageWriteToSavedPhotosAlbum(uiImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
                    return
                }
            }
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        case .denied, .notDetermined, .restricted:
            showTipView()
        }
    }
    
    /**
     保存图片到相册回调
     */
    @objc fileprivate func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: Any) {
        if error != nil {
            JFProgressHUD.showInfoWithStatus("保存失败")
        } else {
            JFProgressHUD.showSuccessWithStatus("保存成功")
        }
    }
    
    /// 提示用户去设置相册权限
    fileprivate func showTipView() {
        JFAlertView(message: "APP不能访问您的相册，可能是您拒绝了我们的请求，请在【设置】-【剑三壁纸库】，允许访问相册", confirm: "设置", cancel: "取消", confirmClosure: {
            // 当前APP打开设置界面
            if let url = URL(string: UIApplicationOpenSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }).show()
    }
    
}
