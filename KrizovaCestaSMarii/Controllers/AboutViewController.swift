//
//  AboutViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 04/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    let about_text: String = "<p>Křížová cesta s Marií<br><br>Offline mobilní verze pro iOS.</p><p>Autor mobilní aplikace: Petr Hráček</p><br><br><p>Případné chyby, připomínky, nápady či postřehy prosím pište na adresu phracek@gmail.com.</p>"
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    var darkMode: Bool = false
    var font_name: String = "Helvetica"
    var font_size: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "O aplikaci"
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
        if self.darkMode {
            darkModeEnabled()
        } else {
            darkModeDisabled()
        }
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
        aboutLabel.numberOfLines = 0
        aboutLabel.attributedText = generateContent(text: about_text)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
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
