//
//  RecommendationViewController.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/27.
//  Copyright © 2017年 fandy. All rights reserved.
//  首页 - 推荐

import UIKit
import Moya
import SwiftyJSON

class RecommendationViewController: BaseViewController {
    
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    let tableHeaderView: UIView = {
        let headerView = UIView()
        
        return headerView
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        getSliderData()
    }
}


// MARK: - Data
extension RecommendationViewController {
    func getSliderData() {
        NewHomeProvider.request(NewHome.slider) { (result) in
            switch result {
            case let .success(response):
                let json = JSON(data: response.data)
                print(json.dictionary ?? "1")
                let abc = SliderData(dict: json.dictionaryValue as [String : AnyObject])
                
            case let .failure(error):
                print(error)
            }
        }
    }
}


// MARK: - UI
extension RecommendationViewController {
    func setupUI() {
        // tableView
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["tableView": tableView]))
        
    }
}























