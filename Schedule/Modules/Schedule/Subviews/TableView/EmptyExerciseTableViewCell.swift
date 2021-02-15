//
//  EmptyExerciseTableViewCell.swift
//  schedule
//
//  Created by Vladislav Glumov on 16.02.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class EmptyExerciseTableViewCell: UITableViewCell {
    
    // MARK: Subviews
    
    private lazy var exerciseTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 253), for: .vertical)
        label.textAlignment = .right
        label.font = UIFont.SFProText(size: 14, weight: .medium)
        label.textColor = UIColor(red: 133 / 255, green: 133 / 255, blue: 133 / 255, alpha: 1)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.preferredMaxLayoutWidth = bounds.size.width
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.SFProDisplay(size: 18, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    // MARK: Interface
    
    var time: String? {
        get { exerciseTimeLabel.text }
        set { exerciseTimeLabel.text = newValue }
    }
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    // MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout subviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            exerciseTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            exerciseTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: exerciseTimeLabel.bottomAnchor, constant: 30),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    // MARK: Configuration method
    
    private func configure() {
        backgroundColor = nil
        contentView.backgroundColor = nil
        
        contentView.addSubview(exerciseTimeLabel)
        contentView.addSubview(titleLabel)
    }
    
}
