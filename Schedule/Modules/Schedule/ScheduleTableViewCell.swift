//
//  CustomTableViewCell.swift
//  Schedule
//
//  Created by vladislav on 26.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import PureLayout

class ScheduleTableViewCell: UITableViewCell {
    
  // MARK: Properties
  
  lazy var timeLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.autoSetDimensions(to: CGSize(width: 64.0, height: 32))
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var parityLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var exerciseLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func updateConstraints() {
    let timeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 0)
    timeLabel.autoPinEdgesToSuperviewEdges(with: timeInsets, excludingEdge: .right)
    
    let parityInsets = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    parityLabel.autoPinEdgesToSuperviewEdges(with: parityInsets, excludingEdge: .top)
    parityLabel.autoPinEdge(.top, to: .bottom, of: timeLabel, withOffset: 8)
    
    let exerciseInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 8)
    exerciseLabel.autoPinEdgesToSuperviewEdges(with: exerciseInsets, excludingEdge: .left)
    exerciseLabel.autoPinEdge(.left, to: .right, of: timeLabel, withOffset: 16)
    
    super.updateConstraints()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.addSubview(timeLabel)
    self.addSubview(parityLabel)
    self.addSubview(exerciseLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
