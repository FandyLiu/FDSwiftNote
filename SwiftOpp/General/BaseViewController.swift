//
//  BaseViewController.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/14.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}
