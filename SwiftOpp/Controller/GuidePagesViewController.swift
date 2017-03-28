//
//  GuidePagesViewController.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/14.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit
import FSPagerView

class GuidePagesViewController: BaseViewController {
    
    fileprivate let imageNames = ["bookstrap_1.jpg", "bookstrap_2.jpg", "bookstrap_3.jpg", "bookstrap_4.jpg", "bookstrap_5.jpg"]
    
    var nextBtnClickAction: () -> ()
    
    lazy var pagerView: FSPagerView = {
        let pagerView: FSPagerView = FSPagerView(frame: self.view.bounds)
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(GuidePagesViewCell.self, forCellWithReuseIdentifier: GuidePagesViewCell.identifier)
        return pagerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pagerView)
    }
    

    init(nextBtnClickAction: @escaping () -> ()) {
        self.nextBtnClickAction = nextBtnClickAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - FSPagerViewDataSource
extension GuidePagesViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: GuidePagesViewCell.identifier, at: index) as! GuidePagesViewCell
        if index == imageNames.count - 1 {
            cell.nextButton.isHidden = false
        }else {
            cell.nextButton.isHidden = true
        }
        cell.imageView?.image = UIImage(named: imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        
        return cell
    }
}

// MARK: - FSPagerViewDelegate
extension GuidePagesViewController: FSPagerViewDelegate {
    
    //TODO: FSPagerViewDelegate
    
}

// MARK: - Action
extension GuidePagesViewController {
    func nextButtonClick() {
        nextBtnClickAction()
    }
}


