//
//  ScheduleView.swift
//  schedule
//
//  Created by vladislav on 22.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import PureLayout

class ScheduleView: UIView {
  
  // MARK: Properties
  
  lazy var segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: ["Today", "Yestarday", "Full"])
    segmentedControl.autoSetDimension(.height, toSize: 32.0)
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.layer.borderColor = UIColor.darkGray.cgColor
    segmentedControl.tintColor = .white
    return segmentedControl
  }()
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .gray
    return tableView
  }()
  
  private func addSubviews() {
    addSubview(segmentedControl)
    addSubview(tableView)
  }
  
  override func updateConstraints() {
    segmentedControl.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
    segmentedControl.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
    segmentedControl.autoPinEdge(toSuperviewEdge: .top, withInset: 80.0)
    
    tableView.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
    tableView.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
    tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8.0)
    tableView.autoPinEdge(.top, to: .bottom, of: segmentedControl, withOffset: 16.0)
    
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
