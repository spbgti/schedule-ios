//
//  CustomTableViewCell.swift
//  Schedule
//
//  Created by vladislav on 26.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
  // MARK: Properties
  
  lazy var timeLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.autoSetDimensions(to: CGSize(width: 64.0, height: 128.0))
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var exerciseLabel: UILabel = {
    let label = UILabel()
    
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var parityLabel: UILabel = {
    let label = UILabel()
    label.autoSetDimensions(to: CGSize(width: 64.0, height: 32.0))
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func updateConstraints() {
    let timeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
    timeLabel.autoPinEdgesToSuperviewEdges(with: timeInsets, excludingEdge: .right)
    
    let parityInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 16)
    parityLabel.autoPinEdgesToSuperviewEdges(with: parityInsets, excludingEdge: .left)
    parityLabel.autoPinEdge(.left, to: .right, of: timeLabel, withOffset: 16)
    
    let exerciseInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
    exerciseLabel.autoPinEdgesToSuperviewEdges(with: exerciseInsets, excludingEdge: .right)
    exerciseLabel.autoPinEdge(.left, to: .right, of: parityLabel, withOffset: 16)
    
    super.updateConstraints()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(timeLabel)
    contentView.addSubview(parityLabel)
    contentView.addSubview(exerciseLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
