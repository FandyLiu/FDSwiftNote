# Xcode8屏蔽打印

###屏蔽的方法如下:

Xcode8里边`Edit Scheme-> Run -> Arguments`, 在`Environment Variables`里边添加`OS_ACTIVITY_MODE ＝ Disable`


![](imgs/dayin.png)



配置之后,一些像麦克风或者摄像头访问权限在 `info.plist` 中的一些key的配置可能`不会打印提醒`从崩溃

![](imgs/bengkui.png)
