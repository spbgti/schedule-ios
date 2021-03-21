//
//  ScheduleTVSectionHeader.swift
//  schedule
//
//  Created by Vladislav Glumov on 17.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

final class ScheduleTVSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: Subviews
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 14, weight: .regular)
        label.textColor = UIColor(red: 132 / 255, green: 132 / 255, blue: 132 / 255, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Property interface
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    // MARK: Initialization
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout subviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    // MARK: Configuration
    
    private func configure() {
        contentView.backgroundColor = UIColor(red: 246 / 255, green: 248 / 255, blue: 247 / 255, alpha: 1)
        contentView.addSubview(titleLabel)
    }
    
}
