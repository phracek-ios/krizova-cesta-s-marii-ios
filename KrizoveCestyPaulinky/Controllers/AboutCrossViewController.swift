//
//  AboutCrossViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 06/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class AboutCrossViewController: BaseViewController, TTTAttributedLabelDelegate {

    fileprivate var bookPaulinkyCZ: String = "https://www.paulinky.cz/obchod/produkt/S-Marii-na-krizove-ceste.html"
    fileprivate var bookCZ: String = "S Marii na krizove ceste"
    fileprivate var bookPaulinkySK: String = "https://www.paulinky.cz/obchod/produkt/S-Mariou-na-krizovej-ceste.html"
    fileprivate var bookSK: String = "S Mariou na krizovej ceste"
    
    var darkMode: Bool = false
    var font_name: String = "Helvetica"
    var font_size: CGFloat = 16
    fileprivate var aboutStructure: AboutStructure?
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var aboutLabel: TTTAttributedLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "O křížové cestě"
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
        self.darkMode = userDefaults.bool(forKey: "NightSwitch")
        var textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        if self.darkMode {
            darkModeEnabled()
            textColor = UIColor.KrizovaCestaSMarii.textNightColor()
        } else {
            darkModeDisabled()
        }
        aboutLabel.numberOfLines = 0
        aboutLabel.delegate = self
        aboutLabel.attributedText = generateContent(text: aboutStructure.about_cross_way, color: textColor)
        aboutLabel.addLink(to: URL(string: bookPaulinkyCZ), with: NSRange(location: 40, length: bookCZ.count))
        aboutLabel.addLink(to: URL(string: bookPaulinkySK), with: NSRange(location: 232, length: bookSK.count))

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.open(url)
    }

    
    func darkModeEnabled() {
        self.darkMode = true
        self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.contentView.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.aboutLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.aboutLabel.textColor = UIColor.KrizovaCestaSMarii.textNightColor()
    }
    
    func darkModeDisabled() {
        self.darkMode = false
        self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.contentView.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.aboutLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.aboutLabel.textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        
    }
}
