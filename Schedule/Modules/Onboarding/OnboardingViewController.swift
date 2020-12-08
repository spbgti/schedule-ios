//
//  LaunchViewController.swift
//  schedule
//
//  Created by vladislav on 21.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    @IBOutlet private var requestForm: GroupRequestForm!
    @IBOutlet private var loader: UIActivityIndicatorView!
    
    var viewModel: OnboardingViewModel = OnboardingViewModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.layer.cornerRadius = 13.0
        requestForm.delegate = self
        hideKeyboardWhenTappedAround()
        configureViewModel()
    }
    
    private func configureViewModel() {
        viewModel.callback = { [weak self] error in
            self?.loader.stopAnimating()
            
            if let error = error {
                Alert.showMessageAlert(on: self!, message: error, title: "Error".localized)
            } else {
                
            }
        }
    }

}

extension OnboardingViewController: RequestFormDelegate {
    func requestForm(_ textFromSearchBar: String) {
        if textFromSearchBar != "" {
            self.loader.startAnimating()
            self.viewModel.fetchGroup(by: textFromSearchBar)
        } else {
            Alert.showMessageAlert(on: self, message: "Enter a group number", title: "Text field is empty".localized)
        }
    }
}

extension OnboardingViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
