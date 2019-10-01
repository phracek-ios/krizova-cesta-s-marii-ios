//
//  Styles.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 13/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation
import BonMot

struct Styles {
    
    // MARK: - Tabs

    static var tabActive = StringStyle(
        .font(UIFont(name: "Helvetica", size: CGFloat(16))!.bold()),
        .color(UIColor.white)
    )
    
    static var tabInActive = StringStyle(
        .font(UIFont(name: "Helvetica", size: 16)!.bold()),
        .color(UIColor.white.withAlphaComponent(0.7))
    )
}
