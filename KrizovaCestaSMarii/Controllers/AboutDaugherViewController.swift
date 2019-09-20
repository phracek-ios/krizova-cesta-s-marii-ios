//
//  AboutDaugherViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 04/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import BonMot

class AboutDaugherViewController: BaseViewController, TTTAttributedLabelDelegate {

    let paulin_email: String = "paulinky@paulinky.cz"
    let paulin_web_cz: String = "https://www.paulinky.cz"
    let paulin_web_org: String = "https://www.paoline.org"
    let paulin_ct: String = "https://www.ceskatelevize.cz/porady/10213629490-zasveceni/210562213000003-paulinky/"
    let paulin_adore: String = "https://www.paulinky.cz/Kontakt/Prosba-o-modlitbu"
    let paulin_watch = "ke shlédnutí"
    let paulin_adore_text = "prosba o modlitbu"
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var aboutLabel: TTTAttributedLabel!
    @IBOutlet weak var contentView: UIView!
    
    var darkMode: Bool = false
    var font_name: String = "Helvetica"
    var font_size: CGFloat = 16
    fileprivate var aboutStructure: AboutStructure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "O Dcerách sv. Pavla"
        aboutStructure = AboutDataService.shared.aboutStructure
        guard let aboutStructure = aboutStructure else { return }
        
        let userDefaults = UserDefaults.standard
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
        let text =  "\(aboutStructure.about_daughters_1)\(paulin_email)<br>\(paulin_web_cz)<br>\(paulin_web_org)</p>\(aboutStructure.about_daughters_2)\(paulin_watch)</p>\(aboutStructure.about_daughters_3)\(paulin_adore_text)</p><br>"
        self.darkMode = userDefaults.bool(forKey: "NightSwitch")
        var textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        if self.darkMode {
            self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            self.contentView.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            aboutLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            aboutLabel.textColor = UIColor.KrizovaCestaSMarii.textNightColor()
            textColor = UIColor.KrizovaCestaSMarii.textNightColor()
        } else {
            self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            self.contentView.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            aboutLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            aboutLabel.textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        }
        aboutLabel.numberOfLines = 0
        aboutLabel.delegate = self
        var numberWords = 0
        aboutLabel.setText(generateContent(text: text, color: textColor))
        aboutLabel.addLink(to: URL(string: paulin_email), with: NSRange(location: aboutStructure.about_daughters_1.count - 45, length: paulin_email.count))
        numberWords += aboutStructure.about_daughters_1.count - 45 + paulin_email.count
        aboutLabel.addLink(to: URL(string: paulin_web_cz), with: NSRange(location: numberWords, length: paulin_web_cz.count))
        numberWords += paulin_web_cz.count
        aboutLabel.addLink(to: URL(string: paulin_web_org), with: NSRange(location: numberWords, length: paulin_web_org.count + 4))
        numberWords += paulin_web_org.count + aboutStructure.about_daughters_2.count - 18
        aboutLabel.addLink(to: URL(string: paulin_ct), with: NSRange(location: numberWords, length: paulin_watch.count + 1))
        numberWords += paulin_watch.count + aboutStructure.about_daughters_3.count - 11
        aboutLabel.addLink(to: URL(string: paulin_adore), with: NSRange(location: numberWords, length: paulin_adore_text.count + 1))
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.open(url)
    }
}
