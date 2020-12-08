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
    
    public var viewModel: OnboardingViewModel = OnboardingViewModel()
    
    override func loadView() {
        super.loadView()
        
        loader.layer.cornerRadius = 13.0
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestForm.delegate = self
        hideKeyboardWhenTappedAround()
        bindViewModel()
    }

}

// MARK: - ViewModel Binding

extension OnboardingViewController {
    private func bindViewModel() {
        viewModel.callback = { [weak self] error in
            self?.loader.stopAnimating()
            
            if let error = error {
                Alert.showError(on: self!, with: error)
            }
        }
    }
}

// MARK: - Methods of RequestFormDelegate

extension OnboardingViewController: RequestFormDelegate {
    func requestForm(_ textFromSearchBar: String) {
        if textFromSearchBar != "" {
            self.loader.startAnimating()
            self.viewModel.fetchGroup(by: textFromSearchBar)
        } else {
            Alert.showError(on: self, with: .dataNotFound)
        }
    }
}

// MARK: - Helpers Methods Of Using System Keyboard

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
