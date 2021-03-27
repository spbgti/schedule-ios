//
//  ScheduleSectionHeader.swift
//  schedule
//
//  Created by Vladislav Glumov on 17.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

final class ScheduleSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: Subviews
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 14, weight: .medium)
        label.textColor = UIColor(red: 80 / 255, green: 80 / 255, blue: 80 / 255, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var topSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 215 / 255, green: 215 / 255, blue: 215 / 255, alpha: 1)
        return view
    }()
    
    private lazy var bottomSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 215 / 255, green: 215 / 255, blue: 215 / 255, alpha: 1)
        return view
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
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            topSeparatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            bottomSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    // MARK: Configuration
    
    private func configure() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(topSeparatorView)
        contentView.addSubview(bottomSeparatorView)
    }
    
}
