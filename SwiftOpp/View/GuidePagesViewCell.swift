//
//  GuidePagesViewCell.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/17.
//  Copyright © 2017年 fandy. All rights reserved.
//  引导页面的 cell

import UIKit
import FSPagerView

class GuidePagesViewCell: FSPagerViewCell {
    
    static let identifier: String = "FSPagerViewCell"

    var nextButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "btn_taste"), for: .normal)
        btn.addTarget(nil, action: #selector(GuidePagesViewController.nextButtonClick), for: .touchUpInside)
        return btn;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension GuidePagesViewCell {
    func setupUI() {
        addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: nextButton,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: self.contentView,
                                              attribute: .centerX,
                                              multiplier: 1.0,
                                              constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: nextButton,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self.contentView,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: -50.0 * DEFAULT_SCALE))
    }
}

