//
//  BaseNavigationController.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/20.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // 初始化
    override class func initialize() {
        let navigationBar = UINavigationBar.appearance(whenContainedInInstancesOf: [self.self])
        navigationBar.setBackgroundImage(UIImage(named: "bg_nav.png"),
                                         for: .topAttached,
                                         barMetrics: .default)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    
    
    init(rootViewController: UIViewController, tabBarItemTitle: String?, tabBarItemImage: String?, tabBarItemSelectedImage: String?) {
        super.init(rootViewController: rootViewController)
        title = tabBarItemTitle
        if let tabBarItemImage = tabBarItemImage {
            tabBarItem.image = UIImage(named: tabBarItemImage)?.withRenderingMode(.alwaysOriginal)
        }
        if let tabBarItemSelectedImage = tabBarItemSelectedImage {
            tabBarItem.selectedImage = UIImage(named: tabBarItemSelectedImage)?.withRenderingMode(.alwaysOriginal)
        }
        // 没有标题处理
        if tabBarItemTitle == nil {
            tabBarItem.imageInsets = UIEdgeInsetsMake(6.0 * DEFAULT_SCALE, 0.0, -6.0 * DEFAULT_SCALE, 0.0)
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    override var childViewControllerForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
  
}

// MARK: - UINavigationControllerDelegate
extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        var isHideNavBar: Bool = false
        if viewController.isKind(of: NewHomePageViewController.self) {
            isHideNavBar = true
        }
        navigationController.setNavigationBarHidden(isHideNavBar, animated: true)
    }
}
