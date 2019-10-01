//
//  MainTableViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 03/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class MainTableViewController: BaseTableViewController {

    enum RowType {
        case maria_cross_stations
        case paul_cross_stations
        case setting
        case about_appl
        case about_daughters
    }
    
    struct RowData {
        let type: RowType
        let menu: CrossStationsMenu?
    }
    
    fileprivate var rowData = [RowData]()
    fileprivate var darkMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCrossStationsMenu()
        let userDefaults = UserDefaults.standard
        self.darkMode = userDefaults.bool(forKey: "NightSwitch")
        if self.darkMode {
            self.tableView.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        } else {
            self.tableView.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        }
        self.tableView.tableFooterView = UIView()
        navigationController?.navigationBar.barTintColor = UIColor.KrizovaCestaSMarii.mainColor()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.KrizovaCestaSMarii.mainTextColor()]
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MainTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainTableViewCell else {
            fatalError("The dequeue cell is not an entrance of MainTableViewCell")
        }
        
        let data = rowData[indexPath.row]
        cell.cellLabel.text = data.menu?.name
        cell.cellImage.image = data.menu?.photo
        if self.darkMode == true {
            cell.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
            cell.cellLabel.textColor = UIColor.KrizovaCestaSMarii.textNightColor()
        }
        else {
            cell.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
            cell.cellLabel.textColor = UIColor.KrizovaCestaSMarii.textLightColor()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = rowData[indexPath.row]
        let mainViewController = UIStoryboard(name: "Main", bundle: nil)
        
        switch data.type {
        case .maria_cross_stations:
            let crossStation = R.storyboard.main.crossTab()!
            navigationController?.pushViewController(crossStation, animated: true)
        case .paul_cross_stations:
            let tabView = R.storyboard.main.crossTab()!
            tabView.mode = 0
            navigationController?.pushViewController(tabView, animated: true)
        case .setting:
            let settingsTableViewController = mainViewController.instantiateViewController(withIdentifier: "Settings")
            navigationController?.pushViewController(settingsTableViewController, animated: true)
        case .about_appl:
            let stabatViewController = mainViewController.instantiateViewController(withIdentifier: "AboutApp")
            navigationController?.pushViewController(stabatViewController, animated: true)
        case .about_daughters:
            let stabatViewController = mainViewController.instantiateViewController(withIdentifier: "AboutDaughters")
            navigationController?.pushViewController(stabatViewController, animated: true)
        }
    }
    
    // MARK: - Navigation
   
    
    private func loadCrossStationsMenu() {
        let iconSettings = UIImage(named: "settings")
        let iconPaulin = UIImage(named: "paulinky")
        let iconMaria = UIImage(named: "maria")
        let iconPaul = UIImage(named: "paul")
        let iconAppl = UIImage(named: "about_appl")
        print("loadCrossMenu")
        guard let maria_cross_station = CrossStationsMenu(name: "Křížová cesta s Marií", photo: iconMaria, order: 0) else {
            fatalError("Unable to instanciate Krizova cesta s Marii")
        }
        guard let paul_cross_station = CrossStationsMenu(name: "Křížová cesta se sv. Pavlem", photo: iconPaul, order: 1) else {
            fatalError("Unable to instanciate Krizova cesta se sv. Pavlem")
        }
        guard let setting = CrossStationsMenu(name: "Nastavení", photo: iconSettings, order: 2) else {
            fatalError("Unable to instanciate Nastaveni")
        }
        guard let about_daughters = CrossStationsMenu(name: "O Dcerách sv. Pavla", photo: iconPaulin, order: 3) else {
            fatalError("Unable to instanciate O dcerach")
        }
        guard let about_app = CrossStationsMenu(name: "O aplikaci", photo: iconAppl, order: 4) else {
            fatalError("Unable to instanciate O aplikaci")
        }
        rowData = [RowData(type: .maria_cross_stations, menu: maria_cross_station)]
        rowData.append(RowData(type: .paul_cross_stations, menu: paul_cross_station))
        rowData.append(RowData(type: .setting, menu: setting))
        rowData.append(RowData(type: .about_daughters, menu: about_daughters))
        rowData.append(RowData(type: .about_appl, menu: about_app))
    }
    @objc private func darkModeEnabled(_ notification: Notification) {
        self.darkMode = true
        self.tableView.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        self.tableView.reloadData()
    }
    
    @objc private func darkModeDisabled(_ notification: Notification) {
        self.darkMode = false
        self.tableView.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        self.tableView.reloadData()
    }
}
