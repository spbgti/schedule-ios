//
//  NotificationSettingTableViewCell.swift
//  schedule
//
//  Created by vladislav on 07.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import PureLayout

class NotificationSettingTableViewCell: UITableViewCell {
  
  // MARK: Properties
  
  lazy var nameLabel: UILabel! = {
    let label = UILabel()
    label.autoSetDimensions(to: CGSize(width: 128, height: 16))
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "Apple SD Gothic Neo", size: 16.0)
    label.textColor = .black
    
    return label
  }()
  
  lazy var timeLabel: UILabel! = {
    let label = UILabel()
    label.autoSetDimensions(to: CGSize(width: 256, height: 64))
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "Apple SD Gothic Neo", size: 56.0)
    label.textColor = .black
    
    return label
  }()
  
  lazy var switchControl: UISwitch! = {
    let switchControl = UISwitch()
    
    return switchControl
  }()
  
  // FIXME: Fix Constraint
  override func updateConstraints() {
    let timeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    timeLabel.autoPinEdgesToSuperviewEdges(with: timeInsets, excludingEdge: .bottom)
    
    let nameInsets = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
    nameLabel.autoPinEdgesToSuperviewEdges(with: nameInsets, excludingEdge: .top)
    nameLabel.autoPinEdge(.top, to: .bottom, of: timeLabel, withOffset: 8.0)
    
    
    super.updateConstraints()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(timeLabel)
    contentView.addSubview(nameLabel)
    contentView.addSubview(switchControl)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
