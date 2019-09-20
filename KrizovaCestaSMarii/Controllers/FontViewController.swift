//
//  FontViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 04/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import Foundation
import BonMot

class FontViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var fontNamePickerView: UIPickerView!
    @IBOutlet weak var fontTextLabel: UILabel!
    
    var pickerData: [[String]] = [[String]]()
    var example_text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac purus nec nisi eleifend aliquet. Duis varius sit amet lacus ac tempus. Phasellus condimentum scelerisque dolor ac placerat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur non tortor vestibulum, euismod dui ut, blandit mauris. In nec congue turpis, sit amet placerat mi. Mauris placerat non metus nec pretium."
    var darkMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        self.fontNamePickerView.delegate = self
        self.fontNamePickerView.dataSource = self
        
        fontTextLabel.numberOfLines = 0
        darkMode = userDefaults.bool(forKey: "NightSwitch")
        let fontNames: [String] = [
            "Arial", "Helvetica", "Times New Roman", "Baskerville", "Didot", "Gill Sans", "Hoefler Text", "Palatino", "Trebuchet MS", "Verdana"
        ]
        let fontSizes: [String] = ["14", "16", "18", "20", "22", "24", "26", "28", "30"]
        pickerData = [fontNames, fontSizes]
        var fontName = userDefaults.string(forKey: "FontName")
        var fontSize = userDefaults.string(forKey: "FontSize")
        if fontName == nil {
            fontName = "Helvetica"
        }
        if fontSize == nil {
            fontSize = "14"
        }
        if darkMode == true {
            self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            self.fontNamePickerView.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            self.fontTextLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            self.fontTextLabel.textColor = UIColor.KrizovaCestaSMarii.textNightColor()
        } else {
            self.view.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            self.fontNamePickerView.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            self.fontTextLabel.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            self.fontTextLabel.textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        }
        fontTextLabel.attributedText = generateContent(text: example_text)
        self.fontNamePickerView.selectRow(fontNames.firstIndex(of: fontName!)!, inComponent: 0, animated: true)
        self.fontNamePickerView.selectRow(fontSizes.firstIndex(of: fontSize!)!, inComponent: 1, animated: true)
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributes = [NSAttributedString.Key.foregroundColor: UIColor.KrizovaCestaSMarii.textLightColor()]
        if self.darkMode == true {
            attributes = [NSAttributedString.Key.foregroundColor: UIColor.KrizovaCestaSMarii.textNightColor()]
        }
        return NSAttributedString(string: self.pickerData[component][row], attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let userDefaults = UserDefaults.standard
        let fontName = pickerData[0][pickerView.selectedRow(inComponent: 0)]
        let fontStr = pickerData[1][pickerView.selectedRow(inComponent: 1)]
        guard let n = NumberFormatter().number(from: fontStr) else { return }
        let fontSize = CGFloat(truncating: n)
        fontTextLabel.attributedText = generateContent(text: example_text, font_name: fontName, size: fontSize)
        userDefaults.set(fontStr, forKey: "FontSize")
        userDefaults.set(fontName, forKey: "FontName")
    }
    
}
