//
//  UIColor+.swift
//  MashUp-Core
//
//  Created by Booung on 2022/07/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString = String(hexString.dropFirst())
        }
        
        var color: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&color)
        
        self.init(red: CGFloat((color & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((color & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(color & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
}
