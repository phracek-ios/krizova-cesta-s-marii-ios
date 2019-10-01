//
//  AboutDataService.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 16/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation

class AboutDataService {
    
    // MARK: - Shared
    static var shared = AboutDataService()
    
    // MARK: - Properties
    var aboutStructure: AboutStructure?
    
    // MARK: -
    func loadData() {
        parseJSON()
    }
    
    private func parseJSON() {
        if let path = Bundle.main.path(forResource: "about", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                aboutStructure = try JSONDecoder().decode(AboutStructure.self, from: data)
                //print(prayerStructure.debugDescription)
            } catch {
                print(error)
            }
        } else {
            print("File not found")
        }
    }
    
}
