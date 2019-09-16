//
//  StationsDataService.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 06/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation

class StationsDataService {
    
    // MARK: - Shared
    static var shared = StationsDataService()
    
    // MARK: - Properties
    var stationsStructure: StationsStructure?
    
    // MARK: -
    func loadData() {
        parseJSON()
    }
    
    private func parseJSON() {
        if let path = Bundle.main.path(forResource: "cross_stations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                stationsStructure = try JSONDecoder().decode(StationsStructure.self, from: data)
                //print(stationsStructure.debugDescription)
            } catch {
                print("Stations Structure")
                print(error)
            }
        } else {
            print("File not found")
        }
    }
    
}
