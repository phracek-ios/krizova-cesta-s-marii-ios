//
//  PaulinPrayerDataService.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 06/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation

class PaulinPrayersDataService {
    
    // MARK: - Shared
    static var shared = PaulinPrayersDataService()
    
    // MARK: - Properties
    var paulinPrayersStructure: PaulinPrayersStructure?
    
    // MARK: -
    func loadData() {
        parseJSON()
    }
    
    private func parseJSON() {
        if let path = Bundle.main.path(forResource: "paulin_prayers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                paulinPrayersStructure = try JSONDecoder().decode(PaulinPrayersStructure.self, from: data)
                //print(paulinPrayersStructure.debugDescription)
            } catch {
                print(error)
            }
        } else {
            print("File not found")
        }
    }
    
}
