//
//  JFWallPaperTool.m
//  JianSanWallpaper
//
//  Created by zhoujianfeng on 16/5/4.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

#import "JFWallPaperTool.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@implementation JFWallPaperTool

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

/**
 *  单例对象
 */
+ (instancetype)shareInstance
{
    static JFWallPaperTool *wallPaperToll = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wallPaperToll = [[self alloc] init];
    });
    return wallPaperToll;
}

- (void)saveAndAsScreenPhotoWithImage:(UIImage *)image imageScreen:(UIImageScreen)imageScreen finished:(void (^)(BOOL success))finished
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (PHAuthorizationStatusAuthorized == status) {
            
            // 保存需要设置为壁纸的图片到相册
            UIImageWriteToSavedPhotosAlbum(image, nil,nil, NULL);
            
            // 获取壁纸控制器
            id wallPaperVc = [self getWallPaperVCWithImage:image];
            
            if (wallPaperVc) {
                switch (imageScreen) {
                    case UIImageScreenHome:
                    {
                        if (self.on) {
                            [wallPaperVc performSelector:NSSelectorFromString(@"setImageAsHomeScreenClicked:") withObject:image];
                        }
                    }
                        break;
                    case UIImageScreenLock:
                    {
                        if (self.on) {
                            [wallPaperVc performSelector:NSSelectorFromString(@"setImageAsLockScreenClicked:") withObject:image];
                        }
                    }
                        break;
                    case UIImageScreenBoth:
                    {
                        if (self.on) {
                            [wallPaperVc performSelector:NSSelectorFromString(@"setImageAsHomeScreenAndLockScreenClicked:") withObject:image];
                        }
                    }
                        break;
                    default:
                        break;
                }
                finished(YES);
            } else {
                finished(NO);
            }
        } else {
            // 无权限
            finished(NO);
        }
    }];
}

#pragma clang diagnostic pop
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (id)getWallPaperVCWithImage:(UIImage *)image
{
    Class wallPaperClass = NSClassFromString(@"PLStaticWallpaperImageViewController");
    id wallPaperInstance = [[wallPaperClass alloc] performSelector:NSSelectorFromString(@"initWithUIImage:") withObject:image];
    [wallPaperInstance setValue:@(YES) forKeyPath:@"saveWallpaperData"];
    return wallPaperInstance;
}
#pragma clang diagnostic pop

@end
