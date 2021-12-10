//
//  Extensions+String.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation
import UIKit

extension String {
    func attributedString(withColor color: UIColor) -> NSAttributedString {
        let range = (self as NSString).range(of: self)
        let mutableStr = NSMutableAttributedString.init(string: self)
        mutableStr.addAttribute(.foregroundColor, value: color, range: range)
        return mutableStr
    }
    
    // source: https://successfulcoder.com/2016/12/17/how-to-calculate-height-of-a-multiline-string-in-swift/
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}
