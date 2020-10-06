//
//  ReminderCVCell.swift
//  schedule
//
//  Created by vladislav on 04.10.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ReminderCVCell: UICollectionViewCell {
    
    @IBOutlet private var coverView: UIView!
    
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var title: UILabel!
    
    @IBOutlet private var time: UILabel!
    
    @IBOutlet private var isRepeat: UILabel!
    @IBOutlet private var isActive: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        coverView.layer.cornerRadius = 10
        coverView.clipsToBounds = true
    }
    
    func set(_ reminder: Reminder) {
        self.title.text = reminder.name
        self.icon.image = reminder.icon
        self.time.text = reminder.time
        
        switch reminder.isActive {
        case true:
            self.isActive.text = "ON"
        case false:
            self.isActive.text = "OFF"
        }
        
        switch reminder.isRepeate {
        case true:
            self.isRepeat.text = "Repeat"
        case false:
            self.isRepeat.text = "No repeat"
        }
    }

}
