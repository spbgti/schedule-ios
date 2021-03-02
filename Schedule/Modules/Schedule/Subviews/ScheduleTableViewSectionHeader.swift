//
//  ScheduleTableViewSectionHeader.swift
//  schedule
//
//  Created by Vladislav Glumov on 16.02.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

final class ScheduleTableViewSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: Subviews
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProDisplay(size: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    // MARK: Interface
    
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
    
    // MARK: Layout of subviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: Configuration method
    
    private func configure() {
        contentView.addSubview(titleLabel)
    }
    
}
