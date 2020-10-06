//
//  NotificationSettingViewController.swift
//  schedule
//
//  Created by vladislav on 11.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ReminderSettingsViewController: UITableViewController {
    
    @IBOutlet private var reminderIcon: UIImageView!
    @IBOutlet private var reminderTitle: UITextField!
    @IBOutlet private var reminderDescription: UITextField!
    @IBOutlet private var remiderTimePicker: UIPickerView!
    @IBOutlet private var isRepeat: UISwitch!
    @IBOutlet private var switchButton: UIButton!
    
    var reminder: Reminder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderIcon.image = reminder.icon
        reminderTitle.text = reminder.name
        isRepeat.isOn = reminder.isRepeate
        reminderDescription.text = reminder.description
        
        switch reminder.isActive {
        case true:
            switchButton.setTitle("Turn off", for: .normal)
        case false:
            switchButton.setTitle("Turn on", for: .normal)
        }
    }
    
    
}
