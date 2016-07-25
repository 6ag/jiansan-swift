//
//  JFWallPaperTool.h
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/5/4.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UIImageScreenHome,
    UIImageScreenLock,
    UIImageScreenBoth
} UIImageScreen;

@interface JFWallPaperTool : NSObject

/**
 *  开关
 */
@property (nonatomic, assign) BOOL on;

/**
 *  一键保存到相册并设置为壁纸
 */
- (void)saveAndAsScreenPhotoWithImage:(UIImage *)image imageScreen:(UIImageScreen)imageScreen finished:(void (^)(BOOL success))finished;

/**
 *  单例对象
 */
+ (instancetype)shareInstance;

@end
