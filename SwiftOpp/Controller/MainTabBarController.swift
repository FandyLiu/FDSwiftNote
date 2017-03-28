//
//  MainTabBarController.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/17.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit


class MainTabBarController: BaseTabBarController {
    // 首页
    lazy var activityNavigationController: BaseNavigationController = {
        return BaseNavigationController(rootViewController: NewHomePageViewController(),
                                        tabBarItemTitle: nil,
                                        tabBarItemImage: "新首页.png",
                                        tabBarItemSelectedImage: "新首页-_选中.png")
        
    }()
    // 消息
    lazy var messageNavigationController: BaseNavigationController = {
        return BaseNavigationController(rootViewController: MessageListViewController(),
                                        tabBarItemTitle: nil,
                                        tabBarItemImage: "新消息.png",
                                        tabBarItemSelectedImage: "新消息_选中.png")
    }()
    // 发布路演
    lazy var releaseNavigationController: BaseNavigationController = {
        return BaseNavigationController(rootViewController: ReleaseViewController(),
                                        tabBarItemTitle: nil,
                                        tabBarItemImage: "发布.png",
                                        tabBarItemSelectedImage: "发布.png")
    }()
    // 发布调研
    lazy var investigateNavigationController: BaseNavigationController = {
        return BaseNavigationController(rootViewController: InvestigateViewController(),
                                        tabBarItemTitle: nil,
                                        tabBarItemImage: "发布.png",
                                        tabBarItemSelectedImage: "发布.png")
    }()
    // 机会
    lazy var opportunityNavigationController: BaseNavigationController = {
        return BaseNavigationController(rootViewController: OpportunityViewController(),
                                        tabBarItemTitle: nil,
                                        tabBarItemImage: "x公司.png",
                                        tabBarItemSelectedImage: "x公司_选中.png")
    }()
    // 我的
    lazy var mineNavigationController: BaseNavigationController = {
        return BaseNavigationController(rootViewController: MineViewController(),
                                        tabBarItemTitle: nil,
                                        tabBarItemImage: "新我.png",
                                        tabBarItemSelectedImage: "新我_选中.png")
    }()
    // 发布需求
    lazy var emptyNavigationController: BaseNavigationController = {
        return BaseNavigationController(rootViewController: BaseViewController(),
                                        tabBarItemTitle: nil,
                                        tabBarItemImage: "发布.png",
                                        tabBarItemSelectedImage: "发布.png")
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupChildViewControllers()
        
        //        delegate = self

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UI
private extension MainTabBarController {
    func setupChildViewControllers() {
        self.setViewControllers([activityNavigationController,
                                 messageNavigationController,
//                                 releaseNavigationController,
                                 investigateNavigationController,
                                 opportunityNavigationController,
                                 mineNavigationController,
//                                 emptyNavigationController
            ], animated: true)
    }
    
    func setupTabBar() {
//        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = UIColor.white
        // 添加阴影
        tabBar.layer.shadowColor = DEFAULT_GRAY_666666.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: -2.5)
        
    }
}
