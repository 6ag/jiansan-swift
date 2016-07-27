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
    private let dbName = "fuck.db"
    
    /// 收藏表
    private let tbName = "fuck"
    
    let dbQueue: FMDatabaseQueue
    
    typealias QueryStarFinished = (result: [[String : AnyObject]]?) -> ()
    
    override init() {
        let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let dbPath = "\(documentPath)/\(dbName)"
        dbQueue = FMDatabaseQueue(path: dbPath)
        super.init()
        
        // 创建收藏表
        createStarTable()
    }
    
    /**
     创建收藏表
     */
    private func createStarTable() {
        let sql = "CREATE TABLE IF NOT EXISTS \(tbName) (" +
            "id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT," +
            "path VARCHAR(80) NOT NULL" +
        ");"
        
        dbQueue.inDatabase { (db) in
            do {
                try db.executeUpdate(sql)
            } catch {
                print("建表失败")
            }
            
        }
    }
    
    /**
     插入收藏壁纸
     
     - parameter path:     收藏的壁纸路径
     */
    func insertStar(path: String) {
        let sql = "INSERT INTO \(tbName) (path) VALUES (\"\(path)\");"
        
        dbQueue.inDatabase { (db) in
            do {
                try db.executeUpdate(sql)
            } catch {
                print("插入数据失败")
            }
        }
        
    }
    
    /**
     获取收藏的壁纸
     - parameter finished:     完成回调
     */
    func getStarWallpaper(finished: QueryStarFinished) -> Void {
        
        // 小量数据不分页
        let sql = "SELECT * FROM \(tbName) ORDER BY id DESC;"
        
        dbQueue.inDatabase { (db) in
            do {
                let result = try db.executeQuery(sql)
                
                var datas = [[String : AnyObject]]()
                while result.next() {
                    let id = result.intForColumn("id")
                    let path = result.stringForColumn("path")
                    
                    datas.append(["id" : Int(id), "path" : path])
                }
                finished(result: datas)
                
            } catch {
                finished(result: nil)
            }
        }
        
    }
    
    /**
     移除指定壁纸
     
     - parameter path: 本地数据库壁纸path
     */
    func removeOneStarWallpaper(path: String) {
        let sql = "DELETE FROM \(tbName) WHERE path = \"\(path)\""
        
        dbQueue.inDatabase { (db) in
            do {
                try db.executeUpdate(sql)
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
                try db.executeUpdate(sql)
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
    func checkIsExists(path: String, finished: (isExists: Bool)->()) {
        
        let sql = "SELECT * FROM \(tbName) WHERE path = \"\(path)\";"
        
        var count = 0
        dbQueue.inDatabase { (db) in
            do {
                let result = try db.executeQuery(sql)
                
                if result.next() {
                    count += 1
                }
                
            } catch {
                print("检测失败")
            }
        }
        
        finished(isExists: count != 0)
    }
    
}
