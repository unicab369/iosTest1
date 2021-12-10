//
//  CustomTextField1.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation
import UIKit

class CustomTextField1: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        self.borderStyle = .none
    }
    
    let padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
