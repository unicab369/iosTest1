//
//  ReturnButton.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/9/21.
//

import Foundation
import UIKit

class ReturnButton: UIButton {
    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }

}
