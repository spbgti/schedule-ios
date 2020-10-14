//
//  Button.swift
//  schedule
//
//  Created by vladislav on 13.10.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure()
    }
    
    private func configure() {
        self.clipsToBounds = true
        self.backgroundColor = .link
        self.layer.cornerRadius = 13.0
        
        self.setTitle("Continue", for: .normal)
    }
    
}
