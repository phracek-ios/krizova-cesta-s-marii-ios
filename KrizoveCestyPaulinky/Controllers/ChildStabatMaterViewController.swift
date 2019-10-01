//
//  ChildStabatMaterViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 06/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import BonMot

class ChildStabatMaterViewController: BaseViewController {
    @IBOutlet weak var childMaterLabel: UILabel!
    fileprivate var stabatStructure: StabatMaterStructure?
    
    var pagerTabTitle: String?
    var pager: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        stabatStructure = StabatMaterDataService.shared.stabatMaterStructure
        // Do any additional setup after loading the view.
        if pager == 0 {
            childMaterLabel.attributedText = generateContent(text: stabatStructure!.czech)
        }
        else {
            childMaterLabel.attributedText = generateContent(text: stabatStructure!.latin)
        }
        
    }
}

// MARK: - IndicatorInfoProvider
extension ChildStabatMaterViewController: IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        return IndicatorInfo(title: pagerTabTitle ?? "")
    }
}
