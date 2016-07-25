# 剑三壁纸库

采用swift编写的一个壁纸类app，PHP后台源码地址: [jiansan-laravel](https://github.com/6ag/jiansan-laravel) ，API接口文档 [http://jiansan.6ag.cn/apidoc/](http://jiansan.6ag.cn/apidoc/) 。

目前还在开发中。。。

## 可抽取封装类库
### **一、JFContextSheet**

这是一个自适应的弹出选项封装，可以适用于各种功能菜单。

#### 导入框架

将项目中 `Vender` 目录下的 `JFContextSheet` 目录拖到你自己的项目。

#### 初始化 **JFContextSheet**

**JFContextSheet** 初始化需要自己创建 `JFContextItem` 对象，每个 `JFContextItem` 代表一个选项，需要传递选项的标题和图片。然后将这些选项通过构造方法传递给 **JFContextSheet** 进行初始化。
**注意:** 选项的点击事件是根据代理来回调的，所以我们需要指定代理对象，这里指定为当前控制器。

```swift
let contextItem1 = JFContextItem(itemName: "返回", itemIcon: "content_icon_back")
let contextItem2 = JFContextItem(itemName: "预览", itemIcon: "content_icon_preview")
let contextItem3 = JFContextItem(itemName: "下载", itemIcon: "content_icon_download")
let contextSheet = JFContextSheet(items: [contextItem1, contextItem2, contextItem3])
contextSheet.delegate = self
```

#### 实现代理 **JFContextSheetDelegate**

这个方法会返回按钮的标题，可以根据标题判断点击的选项

```swift
func contextSheet(contextSheet: JFContextSheet, didSelectItemWithItemName itemName: String) {
  switch (itemName) {
  case "返回":
    break
  case "预览":
    break
  case "下载":
    break
  default:
    break
  }
}
```

### **二、JFWallPaperTool** 一键设置壁纸

总所周知，iPhone设置壁纸非常的坑爹！！！不过利用 `私有api` 可以实现一键设置锁屏壁纸、一键设置主屏幕壁纸、一键设置锁屏和主屏幕壁纸的功能。我今天下载了一些壁纸类的app，发现有几个app里也有这个功能。

*注意:* 已经证实，设置壁纸属于私有api，并且通不过苹果上架扫描。于是乎我在后台添加了一个开关，并且将私有方法用字符串打乱拼接，Apple无法检测到，成功躲过上架审核。

#### 导入框架

将项目中 `Vender` 目录下的 `WallPaperTool` 目录拖到你自己的项目，并导入分类头文件`JFWallPaperTool.h` 。

#### 如何设置

只需要用 `UIImage` 对象调用分类方法进行设置壁纸。

```objc
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
```

#### 实例代码

```swift
let alertController = UIAlertController()

let lockScreen = UIAlertAction(title: "设定锁定屏幕", style: UIAlertActionStyle.Default, handler: { (action) in
    JFWallPaperTool.shareInstance().saveAndAsScreenPhotoWithImage(self.image!, imageScreen: UIImageScreenLock, finished: { (success) in
        if success {
            JFProgressHUD.showSuccessWithStatus("设置成功")
        } else {
            JFProgressHUD.showInfoWithStatus("设置失败")
        }
    })
})

let homeScreen = UIAlertAction(title: "设定主屏幕", style: UIAlertActionStyle.Default, handler: { (action) in
    JFWallPaperTool.shareInstance().saveAndAsScreenPhotoWithImage(self.image!, imageScreen: UIImageScreenHome, finished: { (success) in
        if success {
            JFProgressHUD.showSuccessWithStatus("设置成功")
        } else {
            JFProgressHUD.showInfoWithStatus("设置失败")
        }
    })
})

let homeScreenAndLockScreen = UIAlertAction(title: "同时设定", style: UIAlertActionStyle.Default, handler: { (action) in
    JFWallPaperTool.shareInstance().saveAndAsScreenPhotoWithImage(self.image!, imageScreen: UIImageScreenBoth, finished: { (success) in
        if success {
            JFProgressHUD.showSuccessWithStatus("设置成功")
        } else {
            JFProgressHUD.showInfoWithStatus("设置失败")
        }
    })
})

let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (action) in
    
})

// 添加动作
alertController.addAction(lockScreen)
alertController.addAction(homeScreen)
alertController.addAction(homeScreenAndLockScreen)
alertController.addAction(cancel)

// 弹出选项
presentViewController(alertController, animated: true, completion: {
    
})
```

