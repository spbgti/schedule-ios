//
//  OnboardingViewController.swift
//  schedule
//
//  Created by vladislav on 21.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: DEBUG subviews
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(nil, action: #selector(routeToMainViewController), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Subviews
    
    private lazy var logo: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "onboarding-logo")
        return view
    }()
    
    lazy var textField: UITextField = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(doneAction))
        toolbar.setItems([cancelButton, doneButton], animated: false)
        
        let textField = TextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = false
        textField.font = UIFont.SFProDisplay(size: 14, weight: .regular)
        textField.textColor = UIColor(red: 42 / 255, green: 42 / 255, blue: 42 / 255, alpha: 1)
        textField.inputView = pickerView
        textField.inputAccessoryView = toolbar
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor(red: 193 / 255, green: 193 / 255, blue: 193 / 255, alpha: 1).cgColor
        textField.layer.cornerRadius = 13
        textField.placeholder = "Группа: (выберите группу)"
        return textField
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.color = .gray
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textColor = UIColor(red: 42 / 255, green: 42 / 255, blue: 42 / 255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
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
        button.titleLabel?.font = UIFont.SFProDisplay(size: 20, weight: .medium)
        button.setTitleColor(.link, for: .normal)
        button.setTitleColor(UIColor.gray.withAlphaComponent(0.6), for: .disabled)
        button.setTitle("Продолжить...", for: .normal)
        button.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var footerTextView: UITextView = {
        let attributedText = NSMutableAttributedString()
        
        let lineSpace = NSMutableParagraphStyle()
        lineSpace.lineSpacing = 14
        let attributedStringOfTitle = NSMutableAttributedString(string: "Не нашли номер своей группы?\n",
                                                                attributes: [NSAttributedString.Key.foregroundColor : UIColor.black,
                                                                             NSAttributedString.Key.font : UIFont.SFProDisplay(size: 16, weight: .medium),
                                                                NSAttributedString.Key.paragraphStyle : lineSpace])
        let attributedStringOfSubtitle = NSMutableAttributedString(string: "Обратитесь к нам за помощью",
                                                                   attributes: [
                                                                    NSAttributedString.Key.link : "tg://resolve?domain=vladislavglumov",
                                                                    ])
        attributedText.append(attributedStringOfTitle)
        attributedText.append(attributedStringOfSubtitle)
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.attributedText = attributedText
        textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.gray,
                                       NSAttributedString.Key.font : UIFont.SFProText(size: 14, weight: .regular)]
        textView.textAlignment = .center
        return textView
    }()
    
    // MARK: - Private properties
    
    private var service = GroupsService()
    
    var dataSource: [Group]? {
        didSet {
            pickerView.reloadAllComponents()
            textField.isEnabled = true
        }
    }
    
    var inputGroup: Group?
    
    // MARK: - Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(logo)
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(activityIndicatorView)
        view.addSubview(errorLabel)
        view.addSubview(footerTextView)
        
        #if DEBUG
        view.addSubview(skipButton)
        skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        skipButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        #endif
        
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -52),
            logo.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            logo.heightAnchor.constraint(equalToConstant: 75),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 48),
            button.widthAnchor.constraint(equalToConstant: 182),
            button.heightAnchor.constraint(equalToConstant: 48),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47),
            
            footerTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            footerTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
            footerTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        getGroups()
    }
    
    // MARK: - Service methods
    
    private func getGroups() {
        errorLabel.isHidden = true
        textField.isHidden = true
        button.isHidden = true
        activityIndicatorView.startAnimating()
        
        service.getGroups(number: nil) { [weak self] result in
            switch result {
            case .success(let groups):
                self?.dataSource = groups
                self?.textField.isHidden = false
                self?.button.isHidden = false
                
            case .failure(let error):
                self?.errorLabel.isHidden = false
                self?.errorLabel.text = "Ошибка: \(error.localizedDescription)"
            }
            
            self?.activityIndicatorView.stopAnimating()
        }
    }
    
    // MARK: - Objc methods for target-action patterns
    
    @objc
    private func routeToMainViewController() {
        AppDelegate.shared.rootViewController.switchToScheduleScreen()
    }
    
    @objc
    private func continueAction() {
        guard let group = inputGroup else { return }
        
        do {
            // Try to encode group model
            let groupData: Data = try JSONEncoder().encode(group)
            
            // Save encoded group model to UserDefaults
            UserDefaults.standard.set(groupData, forKey: UserDefaults.Key.group)
            
            // Save an application state than it isn't first launch
            UserDefaults.standard.set(true, forKey: "IS_NOT_FIRST_LAUNCH")
            
            // Route to main module 'MainController'
            routeToMainViewController()
        } catch {
            errorLabel.isHidden = false
            errorLabel.text = "Ошибка: \(error.localizedDescription)"
        }
    }
    
    @objc
    private func doneAction() {
        view.endEditing(true)
        button.isEnabled = inputGroup != nil
    }

}
