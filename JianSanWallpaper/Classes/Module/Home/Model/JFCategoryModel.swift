//
//  JFCategoryModel.swift
//  JianSan Wallpaper
//
//  Created by zhoujianfeng on 16/4/23.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFCategoryModel: NSObject {
    
    /// 分类id
    var id = 0
    
    /// 分类名称
    var name: String?
    
    /// 分类别名
    var alias: String?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    /**
     从网络加载分类数据
     
     - parameter finished: 数据回调
     */
    class func loadCategoriesFromNetwork(_ finished: @escaping (_ categoriesArray: [JFCategoryModel]?, _ error: NSError?) -> ()) {
        
        JFNetworkTools.shareNetworkTools.get(GET_CATEGORIES, parameters: nil) { (success, result, error) in
            
            guard let result = result, success == true else {
                finished(nil, error)
                return
            }
            
            var categoriesArray = [JFCategoryModel]()
            let data = result["data"].arrayObject as! [[String : AnyObject]]
            for dict in data {
                let category = JFCategoryModel(dict: dict)
                categoriesArray.append(category)
            }
            
            finished(categoriesArray, nil)
            
        }
    }
}
