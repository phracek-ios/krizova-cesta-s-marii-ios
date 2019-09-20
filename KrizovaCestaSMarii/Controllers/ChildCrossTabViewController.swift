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
    fileprivate var paulinStructure: PaulinPrayersStructure?
    
    var pagerTabTitle: String?
    var pageContent: String = ""
    var pager: Int = 0
    var mode: Int = 0
    var darkMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stabatStructure = StabatMaterDataService.shared.stabatMaterStructure
        paulinStructure = PaulinPrayersDataService.shared.paulinPrayersStructure
        let userDefaults = UserDefaults.standard
        self.darkMode = userDefaults.bool(forKey: "NightSwitch")
        
        if mode == 0 {
            let userDefaults = UserDefaults.standard
            var invocationMarry: String = ""
            var invocationJesus: String = ""
            if userDefaults.bool(forKey: "InvocationMarry") == true {
                invocationMarry = paulinStructure!.invocationMarry
            }
            if userDefaults.bool(forKey: "InvocationJesus") == true {
                invocationJesus = paulinStructure!.invocationJesus
            }
            childLabel.attributedText = generateContent(text: "\(pageContent)\(invocationMarry)\(invocationJesus)" )
        } else {
            // Do any additional setup after loading the view.
            if pager == 0 {
                childLabel.attributedText = generateContent(text: stabatStructure!.czech)
            }
            else {
                childLabel.attributedText = generateContent(text: stabatStructure!.latin)
            }
        }
        if self.darkMode {
            self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            self.contentView.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            self.childLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            self.childLabel.textColor = UIColor.KrizovaCestaSMarii.textNightColor()
        } else {
            self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            self.contentView.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            self.childLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            self.childLabel.textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        }
    }
}

// MARK: - IndicatorInfoProvider
extension ChildCrossTabViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        return IndicatorInfo(title: pagerTabTitle ?? "")
    }
}
