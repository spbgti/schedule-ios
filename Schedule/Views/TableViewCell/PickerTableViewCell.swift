//
//  PickerViewTableViewCell.swift
//  schedule
//
//  Created by vladislav on 15.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import PureLayout

class PickerTableViewCell: UITableViewCell {
  
  lazy var pickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.autoSetDimensions(to: CGSize(width: 256.0, height: 128))
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerView.backgroundColor = .white
    return pickerView
  }()
  
  override func updateConstraints() {
    let pickerViewInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    pickerView.autoPinEdgesToSuperviewEdges(with: pickerViewInsets)
    
    super.updateConstraints()
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.addSubview(pickerView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


