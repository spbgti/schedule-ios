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
        
        requestForm.delegate = self
        hideKeyboardWhenTappedAround()

        viewModel.callback = { [weak self] error in
            self?.loader.stopAnimating()
            
            if let error = error {
                
            } else {
                
            }
        }
    }
    
    

}

extension OnboardingViewController: RequestFormDelegate {
    func requestForm(_ textFromSearchBar: String) {
        self.loader.startAnimating()
        self.viewModel.fetchGroup(by: textFromSearchBar)
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
