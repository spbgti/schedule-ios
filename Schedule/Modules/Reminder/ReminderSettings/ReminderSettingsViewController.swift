//
//  NotificationSettingViewController.swift
//  schedule
//
//  Created by vladislav on 11.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ReminderSettingsViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var applyButton: UIButton!
    @IBOutlet private var switchView: UISegmentedControl!
    
    @IBOutlet private var pickerView: UIPickerView!
    
    public var callback: ((_: Reminder) -> Void)?
    
    private let notificationManager = NotificationManager()
    
    // TODO: create ReminderViewModel
    var reminder: Reminder!
    
    // TODO: delete test dataSource
    var pickerData: [[String]] = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerData = [["06", "07", "08", "09", "10", "11", "12"],
                      ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]]
        
        let pickerHour = pickerData[0].firstIndex(of: reminder.hour) ?? pickerData.count / 2
        let pickerMinute = pickerData[1].firstIndex(of: reminder.minute) ?? 0
        
        self.view.layer.cornerRadius = 18.0
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(pickerHour, inComponent: 0, animated: false)
        pickerView.selectRow(pickerMinute, inComponent: 2, animated: false)
        
        titleLabel.text = reminder.name
        switchView.selectedSegmentIndex = reminder.isActive ? 0 : 1
    }
    
    @IBAction private func switchActivity() {
        reminder.isActive = switchView.selectedSegmentIndex == 0 ? true : false
    }
    
    @IBAction private func applySettings() {
        let jsonDecoder = JSONEncoder()
        let reminderData = try! jsonDecoder.encode(reminder)
        
        if reminder.isActive {
            notificationManager.addNotification(reminder)
        } else {
            notificationManager.removeNotification(by: reminder.name)
        }
        
        UserDefaults.standard.setValue(reminderData, forKey: reminder.name)
        callback?(reminder)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ReminderSettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return pickerData[0].count
        case 2:
            return pickerData[1].count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return pickerData[0][row]
        case 2:
            return pickerData[1][row]
        default:
            return ":"
        }
    }
}

extension ReminderSettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            reminder.hour = pickerData[0][row]
        case 2:
            reminder.minute = pickerData[1][row]
        default:
            break
        }
    }
}
