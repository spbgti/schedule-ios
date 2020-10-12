//
//  ReminderCVCell.swift
//  schedule
//
//  Created by vladislav on 04.10.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ReminderCVCell: UICollectionViewCell {
    
    @IBOutlet private var title: UILabel!
    @IBOutlet private var time: UILabel!
    @IBOutlet private var isActiveImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 13
        self.clipsToBounds = true
    }
    
    func set(_ reminder: Reminder) {
        self.title.text = reminder.name
        self.time.text = "\(reminder.hour):\(reminder.minute)"
        
        switch reminder.isActive {
        case true:
            self.isActiveImageView.image = UIImage(named: "reminder_on")!
        case false:
            self.isActiveImageView.image = UIImage(named: "reminder_off")!
        }
    }

}
