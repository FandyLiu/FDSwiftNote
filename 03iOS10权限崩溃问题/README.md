# iOS10权限崩溃问题

#####iOS10上，若你的项目访问了隐私数据，比如：相机，相册，通讯录等，app会直接Crash了，这是因为iOS10对用户的隐私做了进一步加强,在申请很多私有权限的时候都需要添加描述，这里我简单的记录了下解决方法。


- 方式一:

在项目中找到`info.plist`文件。
点击`Information Property List` 后边的加号，新添加一项。
在新添加的`key`中输入 `Privacy` 可以迅速定位到这一权限系列，找到你需要的权限，修改后面的 value 就可以了（value内容可随意）。



```
NSBluetoothPeripheralUsageDescription          访问蓝牙
NSCalendarsUsageDescription                    访问日历
NSCameraUsageDescription                       相机
NSPhotoLibraryUsageDescription                 相册
NSContactsUsageDescription                     通讯录
NSLocationAlwaysUsageDescription               始终访问位置
NSLocationUsageDescription                     位置
NSLocationWhenInUseUsageDescription            在使用期间访问位置
NSMicrophoneUsageDescription                   麦克风
NSAppleMusicUsageDescription                   访问媒体资料库
NSHealthShareUsageDescription                  访问健康分享
NSHealthUpdateUsageDescription                 访问健康更新
NSMotionUsageDescription                       访问运动与健身
NSRemindersUsageDescription                    访问提醒事项

```

- 方式二:

在项目中找到`info.plist`文件。
对其右击选`Open As —> Source Code`，以`Source Code`形式打开。
添加相应的键值对即可

```
<key>NSVideoSubscriberAccountUsageDescription</key>
    <string>视频认证</string>
    <key>NSSpeechRecognitionUsageDescription</key>
    <string>语音识别</string>
    <key>NSSiriUsageDescription</key>
    <string>Siri使用</string>
    <key>NSRemindersUsageDescription</key>
    <string>访问提醒事项</string>
    <key>kTCCServiceMediaLibrary</key>
    <string>TV控制</string>
    <key>NSMotionUsageDescription</key>
    <string>运动权限</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>麦克风权限</string>
    <key>NSAppleMusicUsageDescription</key>
    <string>苹果音乐</string>
    <key>NSLocationUsageDescription</key>
    <string>位置权限</string>
    <key>NSHomeKitUsageDescription</key>
    <string>HomeKit权限</string>
    <key>NSHealthUpdateUsageDescription</key>
    <string>健康应用</string>
    <key>NSHealthShareUsageDescription</key>
    <string>健康应用</string>
    <key>NSContactsUsageDescription</key>
    <string>通讯录</string>
    <key>NSCalendarsUsageDescription</key>
    <string>日历</string>
    <key>NSBluetoothPeripheralUsageDescription</key>
    <string>蓝牙</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>相册</string>
    <key>NSCameraUsageDescription</key>
    <string>相机</string>
    <key>NSLocationAlwaysUsageDescription</key>
    <string>永久使用定位</string>
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>应用使用的时候使用定位</string>
```
