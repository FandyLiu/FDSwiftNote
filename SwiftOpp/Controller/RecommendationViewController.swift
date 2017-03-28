//
//  RecommendationViewController.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/27.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

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

        HttpUtil.request(Opp.sliders) { (result) in
            switch result {
            case let .success(response):
                var message = "Couldn't access API"
                let jsonString = try? response.mapString()
                message = jsonString ?? message
                print(message)
            case .failure:
                print(result)
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























