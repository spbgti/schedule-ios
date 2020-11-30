//
//  RequestForm.swift
//  schedule
//
//  Created by Vladislav Glumov on 27.11.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol RequestFormDelegate: class {
    func requestForm(_ textFromSearchBar: String)
}

@IBDesignable
final class GroupRequestForm: UIView {
    
    private lazy var textField: TextField = {
        let textField = TextField()
        return textField
    }()
    
    private lazy var submitButton: Button = {
        let button = Button()
        button.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)
        button.setTitle("button_title-continue".localized, for: .normal)
        return button
    }()
    
    public var delegate: RequestFormDelegate?
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 5.0),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5.0),
            textField.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -20.0),
            textField.heightAnchor.constraint(equalToConstant: 60.0),
            
            submitButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            submitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5.0),
            submitButton.heightAnchor.constraint(equalToConstant: 60.0)
        ])
    }
    
    private func configure() {
        backgroundColor = .clear
        
        addSubview(textField)
        addSubview(submitButton)
    }
    
    @objc
    private func submitButtonAction() {
        guard let textFieldText = self.textField.text, textFieldText != "" else {
            return
        }
        
        delegate?.requestForm(textFieldText)
    }
    
}
