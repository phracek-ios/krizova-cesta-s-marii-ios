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

    fileprivate var bookPaulinkyMariaCZ: String = "https://www.paulinky.cz/obchod/produkt/S-Marii-na-krizove-ceste.html"
    fileprivate var bookMariaCZ: String = "S Marii na krizove ceste"
    fileprivate var bookPaulinkySK: String = "https://www.paulinky.cz/obchod/produkt/S-Mariou-na-krizovej-ceste.html"
    fileprivate var bookSK: String = "S Mariou na krizovej ceste"
    fileprivate var bookPaulinkyPaulCZ: String = "https://www.paulinky.cz/obchod/produkt/Svetlem-pro-me-nohy-je-tve-slovo.html"
    fileprivate var bookPaulCZ: String = "Světlem pro mé nohy je tvé slovo"
    
    var darkMode: Bool = false
    var font_name: String = "Helvetica"
    var font_size: CGFloat = 16
    var mode: Int = 0
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
        if mode == 0 {
            aboutLabel.attributedText = generateContent(text: aboutStructure.about_cross_way_marie, color: textColor)
            aboutLabel.addLink(to: URL(string: bookPaulinkyMariaCZ), with: NSRange(location: 40, length: bookMariaCZ.count))
            aboutLabel.addLink(to: URL(string: bookPaulinkySK), with: NSRange(location: 232, length: bookSK.count))
        } else {
            aboutLabel.attributedText = generateContent(text: aboutStructure.about_cross_way_paul, color: textColor)
            aboutLabel.addLink(to: URL(string: bookPaulinkyPaulCZ), with: NSRange(location: 421, length: bookPaulCZ.count))
        }


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
