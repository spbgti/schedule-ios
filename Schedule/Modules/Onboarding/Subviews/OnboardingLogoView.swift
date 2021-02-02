//
//  OnboardingLogoView.swift
//  schedule
//
//  Created by Vladislav Glumov on 25.01.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class OnboardingLogoView: UIView {
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 38)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Spbgti Code"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor),
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor),
            
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configure() {
        addSubview(icon)
        addSubview(title)
    }
    
}
