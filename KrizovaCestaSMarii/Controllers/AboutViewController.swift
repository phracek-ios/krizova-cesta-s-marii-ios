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
    @IBOutlet weak var contentView: UIView!
    
    var darkMode: Bool = false
    var font_name: String = "Helvetica"
    var font_size: CGFloat = 16
    var mode: Int = 0
    fileprivate var prayStructure: PaulinPrayersStructure?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

        aboutLabel.numberOfLines = 0
        if mode == 0 {
            title = "O aplikaci"
            aboutLabel.attributedText = generateContent(text: about_text)
        } else {
            prayStructure = PaulinPrayersDataService.shared.paulinPrayersStructure
            title = "Modlitby z Paulínského modlitebníku"
            aboutLabel.attributedText = generateContent(text: "\(prayStructure!.good_day)\(prayStructure!.marry_I)\(prayStructure!.marry_II)")
        }
        if self.darkMode {
            self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            self.contentView.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            self.aboutLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            self.aboutLabel.textColor = UIColor.KrizovaCestaSMarii.textNightColor()
        } else {
            self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            self.contentView.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            self.aboutLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            self.aboutLabel.textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
        navigationController?.navigationBar.barStyle = UIBarStyle.black;

    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }
    
    @objc private func darkModeEnabled(_ notification: Notification) {
        self.darkMode = true
        self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.contentView.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.aboutLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.aboutLabel.textColor = UIColor.KrizovaCestaSMarii.textNightColor()
    }
    
    @objc private func darkModeDisabled(_ notification: Notification) {
        self.darkMode = false
        self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.contentView.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.aboutLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.aboutLabel.textColor = UIColor.KrizovaCestaSMarii.textLightColor()
       
    }
}
