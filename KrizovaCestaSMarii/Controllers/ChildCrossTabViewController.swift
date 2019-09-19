//
//  ChildCrossTabViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 17/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import BonMot

class ChildCrossTabViewController: BaseViewController {

    @IBOutlet weak var childLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    fileprivate var stabatStructure: StabatMaterStructure?
    var pagerTabTitle: String?
    var pageContent: String = ""
    var pager: Int = 0
    var mode: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        stabatStructure = StabatMaterDataService.shared.stabatMaterStructure
        if mode == 0 {
            childLabel.attributedText = generateContent(text: pageContent)
        } else {
            // Do any additional setup after loading the view.
            if pager == 0 {
                childLabel.attributedText = generateContent(text: stabatStructure!.czech)
            }
            else {
                childLabel.attributedText = generateContent(text: stabatStructure!.latin)
            }
        }
    }
}

// MARK: - IndicatorInfoProvider
extension ChildCrossTabViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        return IndicatorInfo(title: pagerTabTitle ?? "")
    }
}
