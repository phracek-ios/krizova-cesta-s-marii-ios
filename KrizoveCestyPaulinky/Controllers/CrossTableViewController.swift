//
//  CrossTableViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 30/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class CrossTableViewController: BaseTableViewController {

    enum RowType {
        case about_cross_stations
        case cross_stations
        case stabat_mater
        case pray
    }
    
    struct RowData {
        let type: RowType
        let menu: CrossStationsMenu?
    }
    
    fileprivate var rowData = [RowData]()
    fileprivate var darkMode: Bool = false
    var mode: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCrossStationsMenu()
        if mode == 0 {
            title = "Křížová cesta s Marií"
        } else {
            title = "Křížová cesta se sv. Pavlem"
        }
        let userDefaults = UserDefaults.standard
        self.darkMode = userDefaults.bool(forKey: "NightSwitch")
        if self.darkMode {
            self.tableView.backgroundColor = UIColor.KrizovaCestaSMarii.backNightColor()
        } else {
            self.tableView.backgroundColor = UIColor.KrizovaCestaSMarii.backLightColor()
        }
        self.tableView.tableFooterView = UIView()
        if mode == 0 {
            navigationController?.navigationBar.barTintColor = UIColor.KrizovaCestaSMarii.mainColor()
        } else {
            navigationController?.navigationBar.barTintColor = UIColor.KrizovaCestaSMarii.mainColorP()
        }
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.KrizovaCestaSMarii.mainTextColor()]
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CrossTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CrossTableViewCell else {
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
        return cell    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowData.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = rowData[indexPath.row]
        if data.type == .about_cross_stations {
            let aboutCrossStations = R.storyboard.main.aboutCrossStation()!
            aboutCrossStations.mode = mode
            navigationController?.pushViewController(aboutCrossStations, animated: true)
        }
        else if data.type == .cross_stations {
            let tabView = R.storyboard.main.crossTab()!
            tabView.mode = mode
            navigationController?.pushViewController(tabView, animated: true)
        }
        else if mode == 0 && data.type == .stabat_mater {
            let tabView = R.storyboard.main.crossTab()!
            tabView.mode = 2
            navigationController?.pushViewController(tabView, animated: true)
        }
        else if data.type == .pray {
            if mode == 0 {
                let view = R.storyboard.main.aboutApp()!
                view.mode = 1
                navigationController?.pushViewController(view, animated: true)
            } else {
                let tabView = R.storyboard.main.crossTab()!
                tabView.mode = 3
                navigationController?.pushViewController(tabView, animated: true)
            }
        }
    }
     // MARK: - Navigation
    
     
     private func loadCrossStationsMenu() {
        let iconPray = R.image.pray()
        let iconCrossWay = R.image.crossway()
        let iconStabat = R.image.stabat()
        var iconPath = R.image.path_maria()
        if mode == 1 {
            iconPath = R.image.path_paul()
        }
        
        guard let about_cross_stations = CrossStationsMenu(name: "O křížové cestě", photo: iconPath, order: 0) else {
         fatalError("Unable to instanciate O krizove ceste")
        }
        guard let cross_stations = CrossStationsMenu(name: "Křížová cesta", photo: iconCrossWay, order: 1) else {
         fatalError("Unable to instanciate Krizova cesta")
        }
        guard let stabat_mater = CrossStationsMenu(name: "Stabat mater", photo: iconStabat, order: 2) else {
         fatalError("Unable to instanciate Stabat mater")
        }
        guard let pray = CrossStationsMenu(name: "Modlitby z Paulínského modlitebníku", photo: iconPray, order: 3) else {
         fatalError("Unable to instanciate Modlitby z Paulinky")
        }
        rowData = [RowData(type: .about_cross_stations, menu: about_cross_stations)]
        rowData.append(RowData(type: .cross_stations, menu: cross_stations))
        if mode == 0 {
            rowData.append(RowData(type: .stabat_mater, menu: stabat_mater))
        }
        rowData.append(RowData(type: .pray, menu: pray))
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
