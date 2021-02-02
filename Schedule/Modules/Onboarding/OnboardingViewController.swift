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
    
    private lazy var textField: OnboardingTextField = {
        let textField = OnboardingTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
       
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Продолжить...", for: .normal)
        button.addTarget(self, action: #selector(continueFlow), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private properties
    
    private var service = GroupsService()
    
    private var dataSource: [Group]?
    
    // MARK: - Life cycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGroups()
        
        textField.delegate = self
        textField.dataSource = self
        textField.doneCallback = { [weak self] in
            self?.view.endEditing(true)
        }
        
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
    
    // MARK: - Objc methods
    
    @objc
    private func continueFlow() {
        AppDelegate.shared.rootViewController.switchToScheduleScreen()
    }

}

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
        textField.text = dataSource?[row].number
    }
}
