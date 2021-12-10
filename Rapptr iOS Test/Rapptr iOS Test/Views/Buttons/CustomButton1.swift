//
//  CustomButton1.swift
//  Rapptr iOS Test
//
//  Created by The Alchemist on 12/7/21.
//

import Foundation
import UIKit

class CustomButtom1: UIButton {

    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    func setup() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8.0
        self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        self.imageView?.contentMode = .scaleAspectFit
        self.imageView?.tintColor = .black
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func setImageWithName(_ name: String) {
        guard let image = UIImage(named: name) else { return }
        self.setImage(image, for: .normal)
    }
}
