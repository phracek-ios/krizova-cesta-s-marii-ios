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

class ChildStabatMaterViewController: UIViewController {
    @IBOutlet weak var stabatMaterLabel: UILabel!
    @IBOutlet weak var childMaterLabel: UILabel!
    var pagerTabTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// MARK: - IndicatorInfoProvider
extension ChildStabatMaterViewController: IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        return IndicatorInfo(title: pagerTabTitle ?? "")
    }
}
