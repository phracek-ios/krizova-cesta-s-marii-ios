//
//  CrossTableViewController.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 30/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class CrossTableViewController: UITableViewController {

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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
        }
    }
     // MARK: - Navigation
    
     
     private func loadCrossStationsMenu() {
         let iconPray = UIImage(named: "pray")
         let iconCrossWay = UIImage(named: "crossway")
         let iconStabat = UIImage(named: "stabat")
         let iconPath = UIImage(named: "path")
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
         rowData = [RowData(type: .about_cross_stations, menu: about_cross_stations)]
         rowData.append(RowData(type: .cross_stations, menu: cross_stations))
         rowData.append(RowData(type: .stabat_mater, menu: stabat_mater))
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
