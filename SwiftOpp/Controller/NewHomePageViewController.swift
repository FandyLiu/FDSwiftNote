//
//  NewHomePageViewController.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/20.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class NewHomePageViewController: BaseViewController {
    
    static let items: [(vc: UIViewController.Type, title: String)] = [(RecommendationViewController.self, "推荐"),
                                                                      (OrganizationExchangeViewController.self, "机构交流"),
                                                                      (ExclusiveSurveyViewController.self, "独家调研"),
                                                                      (OrganizationSurveyViewController.self, "机构调研"),
                                                                      (InvestmentViewController.self, "策略会"),
                                                                      (PrivateMeetingViewController.self, "私享汇"),
                                                                      (EssenceViewController.self, "速览"),
                                                                      ]
    
    
    var headTitlesView: HeadTitlesView = {
        let titles = NewHomePageViewController.items.map({ $1 })
        let headTitlesView = HeadTitlesView(titles: titles)
        headTitlesView.frame = CGRect(x: 0.0, y: STATUS_BAR_HEIGHT, width: SCREEN_WIDTH, height: NAV_BAR_HEIGHT)
        headTitlesView.backgroundColor = UIColor.black
        return headTitlesView
    }()
    
    var contentScrollView: UIScrollView = {
        let x = 0.float
        let y = STATUS_AND_NAV_HEIGHT
        let width = SCREEN_WIDTH
        let height = SCREEN_HEIGHT - y
        let contentScrollView: UIScrollView = UIScrollView(frame: CGRect(x: x, y: y, width: width, height: height))
        contentScrollView.backgroundColor = UIColor.white
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.isPagingEnabled = true
        contentScrollView.contentSize = CGSize(width: NewHomePageViewController.items.count.float * SCREEN_WIDTH, height: 0)
        return contentScrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.black
        setupUI()
        headTitlesView.selectButton(withTag: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


// MARK: - UI
extension NewHomePageViewController {
    func setupUI() {
        view.addSubview(headTitlesView)
        view.addSubview(contentScrollView)
        contentScrollView.delegate = self
        headTitlesView.delegate = self
        setupChildViewControllers()
    }
    
    func setupChildViewControllers() {
        for item in NewHomePageViewController.items {
            addOneChildViewController(MyViewController: item.vc, title: item.title)
        }
    }
    
    func addOneChildViewController(MyViewController: UIViewController.Type, title: String) {
        let viewController = MyViewController.init()
        viewController.title = title
        addChildViewController(viewController)
    }
}




// MARK: - UIScrollViewDelegate
extension NewHomePageViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let tag = Int(scrollView.contentOffset.x / SCREEN_WIDTH)
        headTitlesView.selectButton(withTag: tag)
    }
}


// MARK: - HeadTitlesViewDelegate
extension NewHomePageViewController: HeadTitlesViewDelegate {
    func titleButtonClick(button: UIButton) {
        let tag = button.tag
        let vc = childViewControllers[tag]
        let offsetX = tag.float * contentScrollView.bounds.width
        guard (vc.view.superview == nil) else {
            contentScrollView.setContentOffset(CGPoint(x: offsetX , y: 0), animated: true)
            return
        }
        vc.view.frame = CGRect(x: offsetX, y: 0, width: contentScrollView.bounds.width, height: contentScrollView.bounds.height)
        contentScrollView.addSubview(vc.view)
        contentScrollView.setContentOffset(CGPoint(x: offsetX , y: 0), animated: true)
    }
    
    func searchButtonClick(button: UIButton) {
        
    }
}
