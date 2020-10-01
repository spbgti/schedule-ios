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
  
  lazy var timeLabel: UILabel! = {
    let label = UILabel()
    label.autoSetDimensions(to: CGSize(width: 256.0, height: 20))
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "Apple SD Gothic Neo", size: 20.0)
    label.textColor = .gray
    return label
  }()
  
  lazy var conditionLabel: UILabel! = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "Apple SD Gothic Neo", size: 18.0)
    label.textColor = .gray
    return label
  }()
  
  // MARK: Override methods
  
  override func updateConstraints() {
    let timeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 0)
    timeLabel.autoPinEdgesToSuperviewEdges(with: timeInsets, excludingEdge: .right)
    
    let conditionInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 40)
    conditionLabel.autoPinEdgesToSuperviewEdges(with: conditionInsets, excludingEdge: .left)
    super.updateConstraints()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.addSubview(timeLabel)
    self.addSubview(conditionLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
