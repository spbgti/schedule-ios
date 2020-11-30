//
//  TextField.swift
//  schedule
//
//  Created by Vladislav Glumov on 01.12.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UITextField {
    
    private let padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
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
        self.layer.cornerRadius = 13.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        
        self.placeholder = "textfield_placeholder-type_1".localized
    }
    
}
