//
//  CustomLabel1.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation
import UIKit

class CustomLabel1: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .white
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        layer.borderWidth = 1.0
    }
    
    let UIEI = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 5) // as desired

    override var intrinsicContentSize:CGSize {
        numberOfLines = 0       // don't forget!
        var s = super.intrinsicContentSize
        s.height = s.height + UIEI.top + UIEI.bottom
        s.width = s.width + UIEI.left + UIEI.right
        return s
    }

    override func drawText(in rect:CGRect) {
        let r = rect.inset(by: UIEI)
        super.drawText(in: r)
    }

    override func textRect(forBounds bounds:CGRect,
                               limitedToNumberOfLines n:Int) -> CGRect {
        let b = bounds
        let tr = b.inset(by: UIEI)
        let ctr = super.textRect(forBounds: tr, limitedToNumberOfLines: 0)
        // that line of code MUST be LAST in this function, NOT first
        return ctr
    }
}
