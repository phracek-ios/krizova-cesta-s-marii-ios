//
//  SettingsTableViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 04/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class SettingsTableViewController: BaseTableViewController {

    @IBOutlet weak var nightSwitchLabel: UILabel!
    @IBOutlet weak var nightSwitch: UISwitch!
    @IBOutlet weak var dimOffSwitchLabel: UILabel!
    @IBOutlet weak var dimOffSwitch: UISwitch!
    @IBOutlet weak var fontCaptionLabel: UILabel!
    @IBOutlet weak var fontName: UILabel!
    @IBOutlet weak var nightSwitchCell: UITableViewCell!
    @IBOutlet weak var dimOffSwitchCell: UITableViewCell!
    @IBOutlet weak var fontCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nastavení"
        self.tableView.tableFooterView = UIView()
        let userDefaults = UserDefaults.standard
        nightSwitch.isOn = userDefaults.bool(forKey: "NightSwitch")
        if nightSwitch.isOn == true {
            enabledDark()
        }
        else {
            disabledDark()
        }
        dimOffSwitch.isOn = userDefaults.bool(forKey: "DimmScreen")
        set_font_text()
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        set_font_text()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "FontSettings":
            guard let fontController = segue.destination as? FontViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            fontController.navigationItem.title = "Nastavení písma"
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    @IBAction func funcNightMode(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if nightSwitch.isOn == true {
            userDefaults.set(true, forKey: "NightSwitch")
            enabledDark()
            NotificationCenter.default.post(name: .darkModeEnabled, object:nil)
        }
        else {
            userDefaults.set(false, forKey: "NightSwitch")
            disabledDark()
            NotificationCenter.default.post(name: .darkModeDisabled, object: nil)
        }
    }

    @IBAction func funcDisableDisplay(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if dimOffSwitch.isOn == true {
            UIApplication.shared.isIdleTimerDisabled = true
            userDefaults.set(true, forKey: "DimmScreen")
        }
        else {
            UIApplication.shared.isIdleTimerDisabled = false
            userDefaults.set(false, forKey: "DimmScreen")
        }
    }
    
    private func set_font_text() {
        let userDefaults = UserDefaults.standard
        var font_name = userDefaults.string(forKey: "FontName")
        var font_size = userDefaults.string(forKey: "FontSize")
        
        if font_name == nil {
            font_name = "Helvetica"
        }
        if font_size == nil {
            font_size = "16"
        }
        self.fontName.text = "\(String(font_name!)), \(String(font_size!))px"
    }
    func enabledDark() {
        self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.nightSwitch.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.nightSwitchLabel.textColor = UIColor.KrizovaCestaSMarii.textNightColor()
        self.nightSwitchCell.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.dimOffSwitchLabel.textColor = UIColor.KrizovaCestaSMarii.textNightColor()
        self.dimOffSwitch.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.dimOffSwitchCell.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.fontCell.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.fontCaptionLabel.textColor = UIColor.KrizovaCestaSMarii.textNightColor()
        self.fontCaptionLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.fontName.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.fontName.textColor = UIColor.KrizovaCestaSMarii.textNightColor()
        //self.FullScreenLabel.textColor = UIColor.white
    }
    
    func disabledDark() {
        self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.nightSwitch.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.nightSwitchLabel.textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        self.nightSwitchCell.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.dimOffSwitchLabel.textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        self.dimOffSwitch.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.dimOffSwitchCell.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.fontCell.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.fontCaptionLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.fontCaptionLabel.textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        self.fontName.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.fontName.textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        //self.FullScreenLabel.textColor = UIColor.black
    }

}
