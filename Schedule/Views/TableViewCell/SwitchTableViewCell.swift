//
//  switchTableViewCell.swift
//  schedule
//
//  Created by vladislav on 15.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import PureLayout

class SwitchTableViewCell: UITableViewCell {
  
  lazy var switchView: UISwitch = {
    let switchView = UISwitch()
    return switchView
  }()
  
  override func updateConstraints() {
    let switchViewInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 16)
    switchView.autoPinEdgesToSuperviewEdges(with: switchViewInsets, excludingEdge: .left)
    
    super.updateConstraints()
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.addSubview(switchView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
