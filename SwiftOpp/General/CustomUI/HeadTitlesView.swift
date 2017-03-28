//
//  HeadTitlesView.swift
//  SwiftOpp
//
//  Created by QianTuFD on 2017/3/23.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

protocol HeadTitlesViewDelegate: NSObjectProtocol {
    func titleButtonClick(button: UIButton)
    func searchButtonClick(button: UIButton)
}


class HeadTitlesView: UIView {
    var selectedButton: UIButton?
    var titleButtons: [UIButton] = [UIButton]()
    
    weak open var delegate: HeadTitlesViewDelegate?
    
    var titlesScrollView: UIScrollView = {
        let titleScrollView = UIScrollView()
//        titleScrollView.backgroundColor = UIColor.gray
        titleScrollView.showsHorizontalScrollIndicator = false
        titleScrollView.showsVerticalScrollIndicator = false
        return titleScrollView
    }()
    
    var searchButton: UIButton = {
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(UIImage(named: "搜索图标.png"), for: .normal)
        searchButton.addTarget(self, action: #selector(HeadTitlesView.searchButtonClick(btn:)), for: .touchUpInside)
        return searchButton
    }()
    
    init(titles: [String]) {
        super.init(frame: .zero)
        setupUI(titles: titles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - UI
extension HeadTitlesView {
    func setupUI(titles: [String]) {
        addSubview(titlesScrollView)
        addSubview(searchButton)
        
        let MARGIN = CGFloat(10.0)
        let SEARCH_BUTTON_WIDTH = CGFloat(35.0)
        // 添加 head titles
        var btnCenterX = SCREEN_WIDTH * 0.5 - MARGIN
        let btnCenterY = NAV_BAR_HEIGHT * 0.5 - MARGIN
        let btnW = 97.float * DEFAULT_SCALE
        let btnH = 16.float
        
        
        let count = titles.count
        for i in 0..<count {
            let btn = UIButton(type: .custom)
            btn.tag = i
            btnCenterX += (i == 0 ? 0 : 1) * btnW
            btn.bounds = CGRect(x: 0.0, y: 0.0, width: btnW, height: btnH)
            btn.center = CGPoint(x: btnCenterX, y: btnCenterY)
            btn.setTitle(titles[i], for: .normal)
            btn.titleLabel?.font = defaultScaleFont(ofSize: 16)
            btn.setTitleColor(DEFAULT_WHITE_FFFFFF_WITH_ALPHA, for: .normal)
            btn.addTarget(self, action: #selector(HeadTitlesView.titleButtonClick(btn:)), for: .touchUpInside)
            self.titlesScrollView.addSubview(btn)
            if i == 0 {
                self.selectButton(button: btn)
            }
            titleButtons.append(btn)
        }
        let contentSizeX = btnW * (count - 1).float + SCREEN_WIDTH - 3 * MARGIN - SEARCH_BUTTON_WIDTH
        titlesScrollView.contentSize = CGSize(width: contentSizeX, height: 0.0)

        
        
        
        // titlesScrollView
        ({
            titlesScrollView.translatesAutoresizingMaskIntoConstraints = false
            let topConstraint = NSLayoutConstraint(item: titlesScrollView,
                                                   attribute: NSLayoutAttribute.top,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: self,
                                                   attribute: NSLayoutAttribute.top,
                                                   multiplier: 1.0,
                                                   constant: MARGIN)
            let bottomConstraint = NSLayoutConstraint(item: titlesScrollView,
                                                      attribute: NSLayoutAttribute.bottom,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: self,
                                                      attribute: NSLayoutAttribute.bottom,
                                                      multiplier: 1.0,
                                                      constant: -MARGIN)
            let leftConstraint = NSLayoutConstraint(item: titlesScrollView,
                                                    attribute: NSLayoutAttribute.left,
                                                    relatedBy: NSLayoutRelation.equal,
                                                    toItem: self,
                                                    attribute: NSLayoutAttribute.left,
                                                    multiplier: 1.0,
                                                    constant: MARGIN)
            let rightConstraint = NSLayoutConstraint(item: titlesScrollView,
                                                     attribute: NSLayoutAttribute.right,
                                                     relatedBy: NSLayoutRelation.equal,
                                                     toItem: searchButton,
                                                     attribute: NSLayoutAttribute.left,
                                                     multiplier: 1.0,
                                                     constant: -MARGIN)
            addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
            }())
        
        // searchButton
        ({
            searchButton.translatesAutoresizingMaskIntoConstraints = false
            let rightConstraint = NSLayoutConstraint(item: searchButton,
                                                     attribute: NSLayoutAttribute.right,
                                                     relatedBy: NSLayoutRelation.equal,
                                                     toItem: self,
                                                     attribute: NSLayoutAttribute.right,
                                                     multiplier: 1.0,
                                                     constant: -MARGIN)
            let widthConstraint = NSLayoutConstraint(item: searchButton,
                                                     attribute: NSLayoutAttribute.width,
                                                     relatedBy: NSLayoutRelation.equal,
                                                     toItem: nil,
                                                     attribute: NSLayoutAttribute.notAnAttribute,
                                                     multiplier: 0.0,
                                                     constant: SEARCH_BUTTON_WIDTH)
            let heightConstraint = NSLayoutConstraint(item: searchButton,
                                                      attribute: NSLayoutAttribute.height,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: nil,
                                                      attribute: NSLayoutAttribute.notAnAttribute,
                                                      multiplier: 0.0,
                                                      constant: SEARCH_BUTTON_WIDTH)
            let centerYConstraint = NSLayoutConstraint(item: searchButton,
                                                       attribute: NSLayoutAttribute.centerY,
                                                       relatedBy: NSLayoutRelation.equal,
                                                       toItem: self,
                                                       attribute: NSLayoutAttribute.centerY,
                                                       multiplier: 1.0,
                                                       constant: 0.0)
            searchButton.addConstraints([widthConstraint, heightConstraint])
            addConstraints([rightConstraint, centerYConstraint])
            }())
    }
    
    func addButtonConstraints(withTag tag: Int) {
        
    }
    
    
}

// MARK: - Open Fun
extension HeadTitlesView {
    open func selectButton(withTag tag: Int) {
        //        0，1，2   count 3
        assert(titleButtons.count > tag, "数组越界")
        let tagButton = titleButtons[tag]
        titleButtonClick(btn: tagButton)
    }
}



// MARK: - Action
extension HeadTitlesView {
    func titleButtonClick(btn: UIButton) {
        selectButton(button: btn)
        delegate?.titleButtonClick(button: btn)
    }
     func searchButtonClick(btn: UIButton) {
        delegate?.searchButtonClick(button: btn)
    }
    
    
    func selectButton(button: UIButton) {
        selectedButton?.titleLabel?.font = defaultScaleFont(ofSize: 16)
        selectedButton?.setTitleColor(DEFAULT_WHITE_FFFFFF_WITH_ALPHA, for: .normal)
        button.titleLabel?.font = defaultScaleFont(ofSize: 17)
        button.setTitleColor(DEFAULT_WHITE_FFFFFF, for: .normal)
        selectedButton = button
        
        let offsetX = 97.float * DEFAULT_SCALE * button.tag.float
        let offsetPoint = CGPoint(x: offsetX, y: 0)
        titlesScrollView.setContentOffset(offsetPoint, animated: true)
    }
    
}




