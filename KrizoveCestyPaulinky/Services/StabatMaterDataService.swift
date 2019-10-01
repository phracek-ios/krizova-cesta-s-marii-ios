//
//  StabatMaterDataService.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 06/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation

class StabatMaterDataService {
    
    // MARK: - Shared
    static var shared = StabatMaterDataService()
    
    // MARK: - Properties
    var stabatMaterStructure: StabatMaterStructure?
    
    // MARK: -
    func loadData() {
        parseJSON()
    }
    
    private func parseJSON() {
        if let path = Bundle.main.path(forResource: "stabat_mater", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                stabatMaterStructure = try JSONDecoder().decode(StabatMaterStructure.self, from: data)
                //print(stabatMaterStructure.debugDescription)
            } catch {
                print(error)
            }
        } else {
            //print("File not found")
        }
    }
    
}
