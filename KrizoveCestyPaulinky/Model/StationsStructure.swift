//
//  StationsStructure.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 06/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation

struct StationsStructure: Decodable {
    var stationMaria: [Station]
    var stationPaul: [Station]
    var prayer: [Station]
}
