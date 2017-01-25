//
//  JFFMDBManager.swift
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/4/29.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit

class JFFMDBManager: NSObject {
    
    /// 单例对象
    static let sharedManager = JFFMDBManager()
    
    /// sqlite名称
    fileprivate let dbName = "fuck.db"
    
    /// 收藏表
    fileprivate let tbName = "fuck"
    
    let dbQueue: FMDatabaseQueue
    
    typealias QueryStarFinished = (_ result: [[String : AnyObject]]?) -> ()
    
    override init() {
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let dbPath = "\(documentPath)/\(dbName)"
        dbQueue = FMDatabaseQueue(path: dbPath)
        super.init()
        
        // 创建收藏表
        createStarTable()
    }
    
    /**
     创建收藏表
     */
    fileprivate func createStarTable() {
        let sql = "CREATE TABLE IF NOT EXISTS \(tbName) (" +
            "id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT," +
            "path VARCHAR(80) NOT NULL" +
        ");"
        
        dbQueue.inDatabase { (db) in
            do {
                try db?.executeUpdate(sql)
            } catch {
                print("建表失败")
            }
            
        }
    }
    
    /**
     插入收藏壁纸
     
     - parameter path:     收藏的壁纸路径
     */
    func insertStar(_ path: String) {
        let sql = "INSERT INTO \(tbName) (path) VALUES (\"\(path)\");"
        
        dbQueue.inDatabase { (db) in
            do {
                try db?.executeUpdate(sql)
            } catch {
                print("插入数据失败")
            }
        }
        
    }
    
    /**
     获取收藏的壁纸
     - parameter finished:     完成回调
     */
    func getStarWallpaper(_ finished: @escaping QueryStarFinished) -> Void {
        
        // 小量数据不分页
        let sql = "SELECT * FROM \(tbName) ORDER BY id DESC;"
        
        dbQueue.inDatabase { (db) in
            do {
                let result = try db?.executeQuery(sql)
                
                var datas = [[String : AnyObject]]()
                while (result?.next())! {
                    let id = result?.int(forColumn: "id")
                    let path = result?.string(forColumn: "path")
                    
                    datas.append(["id" : Int(id!) as AnyObject, "path" : path as AnyObject])
                }
                finished(datas)
                
            } catch {
                finished(nil)
            }
        }
        
    }
    
    /**
     移除指定壁纸
     
     - parameter path: 本地数据库壁纸path
     */
    func removeOneStarWallpaper(_ path: String) {
        let sql = "DELETE FROM \(tbName) WHERE path = \"\(path)\""
        
        dbQueue.inDatabase { (db) in
            do {
                try db?.executeUpdate(sql)
            } catch {
                print("移除失败")
            }
        }
    }
    
    /**
     移除所有壁纸
     */
    func removeAllStarWallpapaer() {
        
        let sql = "delete from \(tbName);"
        
        dbQueue.inDatabase { (db) in
            do {
                try db?.executeUpdate(sql)
            } catch {
                print("清空失败")
            }
        }
    }
    
    /**
     检查是否存在
     
     - parameter path:     收藏的壁纸路径
     - parameter finished: 检测回调
     */
    func checkIsExists(_ path: String, finished: (_ isExists: Bool)->()) {
        
        let sql = "SELECT * FROM \(tbName) WHERE path = \"\(path)\";"
        
        var count = 0
        dbQueue.inDatabase { (db) in
            do {
                let result = try db?.executeQuery(sql)
                
                if (result?.next())! {
                    count += 1
                }
                
            } catch {
                print("检测失败")
            }
        }
        
        finished(count != 0)
    }
    
}
