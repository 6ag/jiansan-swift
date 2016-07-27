//
//  JFNetworkTools.swift
//  JianSan Wallpaper
//
//  Created by jianfeng on 16/2/4.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class JFNetworkTools: NSObject {
    
    /// 网络请求回调闭包 success:是否成功  flag:预留参数  result:字典数据 error:错误信息
    typealias NetworkFinished = (success: Bool, result: JSON?, error: NSError?) -> ()
    static let shareNetworkTools = JFNetworkTools()
}

extension JFNetworkTools {
    
    /**
     检测壁纸保存状态
     */
    func checkSaveState(finished: (on: Bool)->()) {
        Alamofire.request(.GET, CHECK_SAVE_STATUS).responseJSON { response in
            
            guard let data = response.data else {
                finished(on: false)
                return
            }
            
            let json = JSON(data: data)
            if (json["data"]["content"].stringValue == "1") {
                finished(on: true)
            } else {
                JFProgressHUD.showInfoWithStatus("您的网络不给力")
                finished(on: false)
            }
            
        }
    }
    
    /**
     get请求
     
     - parameter URLString:  接口url
     - parameter parameters: 参数
     - parameter finished:   回调
     */
    func get(URLString: String, parameters: [String : AnyObject], finished: NetworkFinished) {
        
        Alamofire.request(.GET, URLString, parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) in
            
            guard let data = response.data else {
                finished(success: false, result: nil, error: response.result.error)
                return
            }
            
            // 解析json数据
            let json = JSON(data: data)
            
            // 判断是否请求成功
            if (json["meta"]["status"].stringValue == "success") {
                finished(success: true, result: json, error: nil)
            } else {
                JFProgressHUD.showInfoWithStatus("您的网络不给力")
                finished(success: false, result: json, error: response.result.error)
            }
        }
    }
    
    /**
     post请求
     
     - parameter URLString:  接口url
     - parameter parameters: 参数
     - parameter finished:   回调
     */
    func post(URLString: String, parameters: [String : AnyObject], finished: NetworkFinished) {
        
        Alamofire.request(.POST, URLString, parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) in
            
            guard let data = response.data else {
                finished(success: false, result: nil, error: response.result.error)
                return
            }
            
            // 解析json数据
            let json = JSON(data: data)
            
            // 判断是否请求成功
            if (json["meta"]["status"].stringValue == "success") {
                finished(success: true, result: json, error: nil)
            } else {
                JFProgressHUD.showInfoWithStatus("您的网络不给力")
                finished(success: false, result: json, error: response.result.error)
            }
        }
    }
    
}