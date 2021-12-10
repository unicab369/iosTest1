//
//  Styles.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation
import UIKit

// source: https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

class StyleColor {
    static let headerBackground = UIColor(rgb: 0x0E5C89)
    static let viewBackground = UIColor(rgb: 0xF0F0F0)
    static let blue = UIColor(rgb: 0x0E5C89)
    static let black = UIColor(rgb: 0x1B1E1F)
    static let lightBlack = UIColor(rgb: 0x5F6063)
    static let white = UIColor(rgb: 0xFFFFFF)
}

class StyleFont {
    static let headerFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let buttonFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let chatUserNameFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
    static let chatMessageFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    static let loginFont = UIFont.systemFont(ofSize: 16, weight: .regular)
}
