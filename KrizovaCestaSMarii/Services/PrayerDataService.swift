//
//  PrayerDataService.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 06/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation

class PrayerDataService {
    
    // MARK: - Shared
    static var shared = PrayerDataService()
    
    // MARK: - Properties
    var prayerStructure: PrayerStructure?
    
    // MARK: -
    func loadData() {
        parseJSON()
    }
    
    private func parseJSON() {
        if let path = Bundle.main.path(forResource: "prayer", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                prayerStructure = try JSONDecoder().decode(PrayerStructure.self, from: data)
                //print(prayerStructure.debugDescription)
            } catch {
                print(error)
            }
        } else {
            print("File not found")
        }
    }
    
}
