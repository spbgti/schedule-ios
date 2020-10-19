//
//  CustomTableViewCell.swift
//  Schedule
//
//  Created by vladislav on 26.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var exerciseLabel: UILabel!
    @IBOutlet private var exerciseTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    func setTime(_ time: String) {
        timeLabel.text = time
    }
    
    func setName(_ name: String) {
        exerciseLabel.text = name
    }
    
    func setType(_ type: String?) {
        exerciseTypeLabel.text = type
    }
  
}
