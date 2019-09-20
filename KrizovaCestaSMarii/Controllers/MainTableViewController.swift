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
        case about_cross_stations
        case cross_stations
        case stabat_mater
        case pray
        case setting
        case about_app
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        case .about_cross_stations:
            let aboutCrossStations = mainViewController.instantiateViewController(withIdentifier: "AboutCrossStation")
            navigationController?.pushViewController(aboutCrossStations, animated: true)
        case .cross_stations:
            let tabView = R.storyboard.main.crossTab()!
            tabView.mode = 0
            navigationController?.pushViewController(tabView, animated: true)
        case .stabat_mater:
            let tabView = R.storyboard.main.crossTab()!
            tabView.mode = 1
            navigationController?.pushViewController(tabView, animated: true)
        case .pray:
            let view = R.storyboard.main.aboutApp()!
            view.mode = 1
            navigationController?.pushViewController(view, animated: true)
        case .setting:
            let settingsTableViewController = mainViewController.instantiateViewController(withIdentifier: "Settings")
            navigationController?.pushViewController(settingsTableViewController, animated: true)
        case .about_app:
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
        let iconPray = UIImage(named: "pray")
        let iconCrossWay = UIImage(named: "crossway")
        let iconPaulin = UIImage(named: "paulinky")
        let iconStabat = UIImage(named: "stabat")
        let iconPath = UIImage(named: "path")
        let iconAppl = UIImage(named: "about_appl")
        guard let about_cross_stations = CrossStationsMenu(name: "O křížové cestě", photo: iconPath, order: 0) else {
            fatalError("Unable to instanciate Procházet kapitoly")
        }
        guard let cross_stations = CrossStationsMenu(name: "Křížová cesta", photo: iconCrossWay, order: 1) else {
            fatalError("Unable to instanciate Hledat podle čísel")
        }
        guard let stabat_mater = CrossStationsMenu(name: "Stabat mater", photo: iconStabat, order: 2) else {
            fatalError("Unable to instanciate Vyhledávání")
        }
        guard let pray = CrossStationsMenu(name: "Modlitby z Paulínského modlitebníku", photo: iconPray, order: 3) else {
            fatalError("Unable to instanciate Hledat podle čísel")
        }
        guard let setting = CrossStationsMenu(name: "Nastavení", photo: iconSettings, order: 3) else {
            fatalError("Unable to instanciate Rejstřík")
        }
        guard let about_app = CrossStationsMenu(name: "O aplikaci", photo: iconAppl, order: 5) else {
            fatalError("Unable to instanciate O projektu")
        }
        guard let about_daughters = CrossStationsMenu(name: "O Dcerách sv. Pavla", photo: iconPaulin, order: 7) else {
            fatalError("Unable to instanciate O aplikaci")
        }
        
        rowData = [RowData(type: .about_cross_stations, menu: about_cross_stations)]
        rowData.append(RowData(type: .cross_stations, menu: cross_stations))
        rowData.append(RowData(type: .stabat_mater, menu: stabat_mater))
        rowData.append(RowData(type: .pray, menu: pray))
        rowData.append(RowData(type: .setting, menu: setting))
        rowData.append(RowData(type: .about_app, menu: about_app))
        rowData.append(RowData(type: .about_daughters, menu: about_daughters))
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
