# Xcode8屏蔽打印

###屏蔽的方法如下:

Xcode8里边`Edit Scheme-> Run -> Arguments`, 在`Environment Variables`里边添加`OS_ACTIVITY_MODE ＝ Disable`


![](imgs/dayin.png)



配置之后,一些像麦克风或者摄像头访问权限在 `info.plist` 中的一些key的配置可能`不会打印提醒`从而崩溃

项目打印提示类似于

```
This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSSpeechRecognitionUsageDescription key with a string value explaining to the user how the app uses this data.

```


![](imgs/bengkui.png)

遇到这些问题可以去[iOS10权限崩溃问题](../03iOS10权限崩溃问题/README.md)中查看如何配置
