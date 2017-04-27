//
//  SliderData.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/28.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class SliderModel: NSObject {
    var MobileShowImage: String = ""
    var FunctionValue: String = ""
    var FunctionType: String = ""
    var ShowName: String = ""
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}



class SliderData: NSObject {
    var encrypt: Int = 0
    var data: [SliderModel] = [SliderModel]()
    var levelState: Int = 0
    var code: Int = 0
    var zip: Int = 0
    var msg: String = ""
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
