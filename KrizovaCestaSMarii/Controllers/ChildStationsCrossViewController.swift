//
//  ChildStationsCrossViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 17/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import BonMot

class ChildStationsCrossViewController: BaseViewController {

    @IBOutlet weak var childLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    var pagerTabTitle: String?
    var pageContent: String = ""
    var pager: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        childLabel.attributedText = generateContent(text: pageContent)
    }
}

// MARK: - IndicatorInfoProvider
extension ChildStationsCrossViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        return IndicatorInfo(title: pagerTabTitle ?? "")
    }
}
