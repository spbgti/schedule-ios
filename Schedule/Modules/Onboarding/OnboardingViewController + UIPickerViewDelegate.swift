//
//  OnboardingViewController + UIPickerViewDelegate.swift
//  schedule
//
//  Created by Vladislav Glumov on 04.02.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

extension OnboardingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataSource?.count ?? 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataSource?[row].number
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let group = dataSource?[row]
        textField.text = group?.number
        inputGroup = group
    }
}
