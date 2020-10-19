//
//  GroupSettingsViewController.swift
//  schedule
//
//  Created by vladislav on 13.10.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class GroupSettingsViewController: UIViewController {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var validatingLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var button: Button!
    @IBOutlet private var loader: UIActivityIndicatorView!
    
    private var groupService = GroupsService()
    
    var callback: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 13.0
        
        validatingLabel.isHidden = true
        
        setupTextField()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction private func changeGroupNumber() {
        self.validatingLabel.isHidden = true
        self.loader.startAnimating()
        
        guard let groupNumberText = textField.text else {
            self.validatingLabel.text = "Text field is empty"
            return
        }
        
        groupService.getGroups(number: groupNumberText) { [weak self] result in
            switch result {
            case .success(let groups):
                self?.loader.stopAnimating()
                
                if groups.count > 0, let group = groups.first {
                    UserDefaults.standard.set(group.groupId, forKey: "GROUP_ID")
                    UserDefaults.standard.set(group.number, forKey: "GROUP_NUMBER")
                    self?.callback?()
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    self?.validatingLabel.text = "Group not found"
                    self?.validatingLabel.isHidden = false
                }
            case .failure( _):
                self?.loader.stopAnimating()
                self?.validatingLabel.text = "Group not found"
                self?.validatingLabel.isHidden = false
            }
        }
    }
    
    private func setupTextField() {
        let toolBar = UIToolbar(frame: CGRect(origin: .zero,
                                              size: .init(width: self.view.bounds.size.width,
                                                          height: 30.0)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(endEditing))
        toolBar.setItems([flexSpace, doneButton], animated: false)
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc
    private func endEditing() {
        self.view.endEditing(true)
    }
    
}
