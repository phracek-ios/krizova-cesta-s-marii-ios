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
    var font_name: String = "Helvetica"
    var font_size: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stabatStructure = StabatMaterDataService.shared.stabatMaterStructure
        paulinStructure = PaulinPrayersDataService.shared.paulinPrayersStructure
        let userDefaults = UserDefaults.standard
        self.darkMode = userDefaults.bool(forKey: "NightSwitch")

        if let saveFontName = userDefaults.string(forKey: "FontName") {
            self.font_name = saveFontName
        } else {
            userDefaults.set("Helvetica", forKey: "FontName")
        }
        if let saveFontSize = userDefaults.string(forKey: "FontSize") {
            guard let n = NumberFormatter().number(from: saveFontSize) else { return }
            self.font_size = CGFloat(truncating: n)
        } else {
            userDefaults.set(16, forKey: "FontSize")
            self.font_size = 16
        }
        var attributedText: NSAttributedString
        if mode == 0 {
            var invocationMarry: String = ""
            var invocationJesus: String = ""
            if userDefaults.bool(forKey: "InvocationMarry") == true {
                invocationMarry = paulinStructure!.invocationMarry
            }
            if userDefaults.bool(forKey: "InvocationJesus") == true {
                invocationJesus = paulinStructure!.invocationJesus
            }
            attributedText = generateContent(text: "\(pageContent)\(invocationMarry)\(invocationJesus)",
                font_name: self.font_name, size: self.font_size)
        } else if mode == 1 {
            attributedText = generateContent(text: "\(pageContent)",
                font_name: self.font_name, size: self.font_size)
        } else {
            // Do any additional setup after loading the view.
            if pager == 0 {
                attributedText = generateContent(text: stabatStructure!.czech, font_name: self.font_name, size: self.font_size)
            }
            else {
                attributedText = generateContent(text: stabatStructure!.latin, font_name: self.font_name, size: self.font_size)
            }
        }
        childLabel.attributedText = attributedText
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
