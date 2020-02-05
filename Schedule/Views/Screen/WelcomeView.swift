//
//  WelcomeView.swift
//  schedule
//
//  Created by vladislav on 21.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import PureLayout

class WelcomeView: UIView {
  
  // MARK: Properties
  
  lazy var welcomeLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.textColor = .black
    label.font = UIFont(name: "Apple SD Gothic Neo", size: 32.0)
    label.textAlignment = .center
    
    return label
  }()
  
  lazy var groupNumberTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Enter group number"
    textField.autoSetDimension(.width, toSize: 96.0)
    textField.autoSetDimension(.height, toSize: 32.0)
    
    return textField
  }()
  
  lazy var saveButton: UIButton = {
    let button = UIButton()
    button.setTitle("Save", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 4.0
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.borderWidth = 2.0
    button.tintColor = .gray
    button.backgroundColor = .gray
    button.autoSetDimension(.width, toSize: 96.0)
    button.autoSetDimension(.height, toSize: 64.0)
    
    return button
  }()
  
  private func addSubviews() {
    addSubview(welcomeLabel)
    addSubview(groupNumberTextField)
    addSubview(saveButton)
  }
  
  override func updateConstraints() {
    welcomeLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 32.0)
    welcomeLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 32.0)
    welcomeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 128.0)
    
    groupNumberTextField.autoPinEdge(toSuperviewEdge: .left, withInset: 32.0)
    groupNumberTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 32.0)
    groupNumberTextField.autoPinEdge(.top, to: .bottom, of: welcomeLabel, withOffset: 64.0)
    
    saveButton.autoPinEdge(toSuperviewEdge: .left, withInset: 32.0)
    saveButton.autoPinEdge(toSuperviewEdge: .right, withInset: 32.0)
    saveButton.autoPinEdge(.top, to: .bottom, of: groupNumberTextField, withOffset: 32.0)
    
    super.updateConstraints()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
