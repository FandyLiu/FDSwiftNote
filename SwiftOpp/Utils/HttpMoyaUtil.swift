//
//  HttpMoyaUtil.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/20.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit
import Moya

let HttpUtil = MoyaProvider<Opp>()

enum Opp {
    case sliders
}


extension Opp: TargetType {
    var baseURL: URL {
        return URL(string: "http://api.jhbshow.com")!
    }
    
    var path: String {
        switch self {
        case .sliders:
            return "Jhb/GetSlides"
        } 
        
    }
    
    var method: Moya.Method {
        switch self {
        case .sliders:
            return .post
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .sliders:
            return [
                "deviceId": "86DC495B-386E-42F9-BF04-6AF08EA13781",
                "isEncrypt": "0",
                "type": "1",
                "parameters": [String: Any]()
            ]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    
    var task: Task {
        switch self {
        case .sliders:
            return .request
            
        }
    }
    
    var sampleData: Data {
        return Data(base64Encoded: "aaa", options: [])!
    }

    
    
    
    
}
