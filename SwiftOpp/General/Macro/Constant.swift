//
//  Constant.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/17.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

let STATUS_BAR_HEIGHT = CGFloat(20.0)
let NAV_BAR_HEIGHT = CGFloat(44.0)
let STATUS_AND_NAV_HEIGHT = STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT

let SCREEN_BOUNDS = UIScreen.main.bounds
let SCREEN_SIZE = UIScreen.main.bounds.size

let SCREEN_WIDTH = SCREEN_BOUNDS.width
let SCREEN_HEIGHT = SCREEN_BOUNDS.height

let CONTENT_HEIGHT = SCREEN_HEIGHT - STATUS_AND_NAV_HEIGHT

let SCREEN_RESOLUTION = SCREEN_WIDTH * SCREEN_HEIGHT * SCREEN_SCALE
let SCREEN_SCALE = UIScreen.main.scale


let DEFAULT_SCALE = UIScreen.main.bounds.width / 375.0

func defaultScaleFont(ofSize fontSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: fontSize * DEFAULT_SCALE)
}







let DEFAULT_GRAY_666666 = UIColor(red: 102.0 / 255.0, green: 102.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)

let DEFAULT_WHITE_FFFFFF_WITH_ALPHA = UIColor(white: 1.0, alpha: 0.35)
let DEFAULT_WHITE_FFFFFF = UIColor(white: 1.0, alpha: 1.0)







