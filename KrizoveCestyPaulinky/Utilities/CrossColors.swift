//
//  CrossColors.swift
//  KrizovaCestaSMarii
//
//  Created by Petr Hracek on 04/09/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation
import UIKit
import DynamicColor

extension UIColor {
    struct KrizovaCestaSMarii {
        
        // Mark: - UIColor
        
        // Mark: - UIColor
        
        static func mainColor() -> UIColor {
            return UIColor(hexString: "#0168ba")
        }
        
        static func mainColorP() -> UIColor {
            return UIColor(hexString: "#851d01")
        }
        
        static func mainColor2() -> UIColor {
            return UIColor(hexString: "#072975")
        }
        static func yellowColor() -> UIColor {
            return UIColor(hexString: "#FDD93F")
        }
        
        static func textLightColor() -> UIColor {
            return UIColor.black
        }
        
        static func textNightColor() -> UIColor {
            return UIColor.white
        }
        
        static func backLightColor() -> UIColor {
            return UIColor.white
        }
        
        static func backNightColor() -> UIColor {
            return UIColor.black
        }
        
        static func mainTextColor() -> UIColor {
            return UIColor.white
        }
    }
}
