//
//  OnboardingViewController + UITextViewDelegate.swift
//  schedule
//
//  Created by Vladislav Glumov on 05.02.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

extension OnboardingViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.canOpenURL(URL)
        return true
    }
}
