//
//  OnboardingTextField.swift
//  schedule
//
//  Created by Vladislav Glumov on 26.01.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class OnboardingTextField: UIView {
    
    private lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Номер группы"
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.textColor = UIColor(red: 85 / 255, green: 85 / 255, blue: 85 / 255, alpha: 85 / 255)
        textField.placeholder = "..."
        textField.inputView = pickerView
        textField.inputAccessoryView = toolbar
        return textField
    }()
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(todo))
        toolbar.setItems([doneButton], animated: false)
        
        return toolbar
    }()
    
    var delegate: UIPickerViewDelegate? {
        didSet {
            pickerView.delegate = delegate
        }
    }
    
    var dataSource: UIPickerViewDataSource? {
        didSet {
            pickerView.dataSource = dataSource
        }
    }
    
    var text: String? {
        didSet {
            textField.text = text
        }
    }
    
    var doneCallback: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
            title.widthAnchor.constraint(equalToConstant: 110),
            
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 14),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func configure() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 193 / 255, green: 193 / 255, blue: 193 / 255, alpha: 193 / 255).cgColor
        layer.cornerRadius = 13
        
        addSubview(title)
        addSubview(textField)
    }
    
    @objc
    func todo() {
        doneCallback?()
    }
    
}
