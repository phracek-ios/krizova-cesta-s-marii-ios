//
//  CrossStattionsMenu.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 04/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation
import UIKit

class CrossStationsMenu {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var order: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, order: Int){
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        // The type must not be negative
        guard (order >= 0) && (order <= 8) else {
            return nil
        }
        // Initialize stored properties
        self.name = name
        self.photo = photo
        self.order = order
        
    }
}
