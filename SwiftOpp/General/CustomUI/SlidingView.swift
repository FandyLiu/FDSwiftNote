//
//  SlidingView.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/28.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class SlidingView: UIView {
    var placehoderView: UIImageView = {
        return UIImageView(image: UIImage(named: "bg_cover_banner.png"))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(placehoderView)
    }
}
