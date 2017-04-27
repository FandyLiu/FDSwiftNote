//
//  NewHomeAPI.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/28.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit
import Moya

let NewHomeProvider = MoyaProvider<NewHome>()

enum NewHome {
    case slider
}

extension NewHome: TargetType {
    var baseURL: URL {
        return URL(string: "http://api.jhbshow.com")!
    }
    
    var path: String {
        switch self {
        case .slider:
            return "Jhb/GetSlides"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .slider:
            return .post
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .slider:
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
        case .slider:
            return .request
            
        }
    }
    
    var sampleData: Data {
        return Data(base64Encoded: "aaa", options: [])!
    }

}
