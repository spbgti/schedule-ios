//
//  LaunchViewController.swift
//  schedule
//
//  Created by vladislav on 21.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - Subviews
    
    private lazy var logo: OnboardingLogoView = {
        let view = OnboardingLogoView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var textField: UITextField = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(todo))
        toolbar.setItems([doneButton], animated: false)
        
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = false
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.textColor = UIColor(red: 85 / 255, green: 85 / 255, blue: 85 / 255, alpha: 85 / 255)
        textField.inputView = pickerView
        textField.inputAccessoryView = toolbar
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor(red: 193 / 255, green: 193 / 255, blue: 193 / 255, alpha: 193 / 255).cgColor
        textField.layer.cornerRadius = 13
        
        return textField
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.link, for: .normal)
        button.setTitleColor(UIColor.link.withAlphaComponent(0.6), for: .disabled)
        button.setTitle("Продолжить...", for: .normal)
        button.addTarget(self, action: #selector(continueFlow), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private properties
    
    private var service = GroupsService()
    
    private var dataSource: [Group]? {
        didSet {
            pickerView.reloadAllComponents()
            textField.isEnabled = true
        }
    }
    
    private var inputGroup: Group?
    
    // MARK: - Life cycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(logo)
        view.addSubview(textField)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -40),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            logo.heightAnchor.constraint(equalToConstant: 75),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 72),
            button.widthAnchor.constraint(equalToConstant: 182),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        getGroups()
    }
    
    // MARK: - Service methods
    
    private func getGroups() {
        service.getGroups(number: nil) { [weak self] result in
            switch result {
            case .success(let groups):
                self?.dataSource = groups
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Objc methods for target-action patterns
    
    @objc
    private func continueFlow() {
        guard let group = inputGroup else { return }
        let groupData: Data = try! JSONEncoder().encode(group)
        
        UserDefaults.standard.set(groupData, forKey: UserDefaults.Key.group)
        AppDelegate.shared.rootViewController.switchToScheduleScreen()
    }
    
    @objc
    private func todo() {
        view.endEditing(true)
        button.isEnabled = inputGroup != nil
    }

}

// MARK: Delegate methods of PickerView

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
