//
//  GroupSettingCell.swift
//  schedule
//
//  Created by vladislav on 03.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import PureLayout

class GroupSettingTableViewCell: UITableViewCell {
  
  // MARK: Properties
  
  lazy var groupNumberLabel: UILabel? = {
    let label = UILabel()
    label.autoSetDimensions(to: CGSize(width: 512.0, height: 32.0))
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var changeGroupButton: UIButton = {
    let button = UIButton()
    button.autoSetDimensions(to: CGSize(width: 256, height: 32.0))
    button.setTitleColor(.systemBlue, for: .normal)
    button.contentHorizontalAlignment = .left
    return button
  }()
  
  // FIXME: Fix Constraint
  override func updateConstraints() {
    let groupNumberLabelInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    groupNumberLabel?.autoPinEdgesToSuperviewEdges(with: groupNumberLabelInsets)
     
    let changeGroupbuttonInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    changeGroupButton.autoPinEdgesToSuperviewEdges(with: changeGroupbuttonInsets)
    
    super.updateConstraints()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(groupNumberLabel!)
    contentView.addSubview(changeGroupButton)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
