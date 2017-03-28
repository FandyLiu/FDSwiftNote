//
//  VersionManager.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/14.
//  Copyright © 2017年 fandy. All rights reserved.
//  应用版本管理工具类

import UIKit


class VersionManager {
    static let key_ShortVersion = "key_ShortVersion"
    class func isShowGuidePages() -> Bool {
        let localShortVersion = UserDefaults.standard.object(forKey: key_ShortVersion) as? String
        let currentShortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        guard let localShortVersionStr = localShortVersion,
            let currentShortVersionStr = currentShortVersion else {
                UserDefaults.standard.set(currentShortVersion, forKey: key_ShortVersion)
                return true;
        }
        if localShortVersionStr < currentShortVersionStr {
            UserDefaults.standard.set(currentShortVersion, forKey: key_ShortVersion)
            return true;
        }else {
            return false;
        }
    }
}
