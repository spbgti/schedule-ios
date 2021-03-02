//
//  ExerciseTableViewCell.swift
//  schedule
//
//  Created by Vladislav Glumov on 11.02.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

final class ExerciseTableViewCell: UITableViewCell {
    
    // MARK: Subviews
    
    private lazy var typeOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 253), for: .vertical)
        label.textAlignment = .left
        label.font = UIFont.SFProText(size: 14, weight: .medium)
        label.textColor = UIColor(red: 133 / 255, green: 133 / 255, blue: 133 / 255, alpha: 1)
        return label
    }()
    
    private lazy var timeOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 253), for: .vertical)
        label.textAlignment = .right
        label.font = UIFont.SFProText(size: 14, weight: .medium)
        label.textColor = UIColor(red: 133 / 255, green: 133 / 255, blue: 133 / 255, alpha: 1)
        return label
    }()
    
    private lazy var nameOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = bounds.size.width
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.SFProDisplay(size: 18, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProDisplay(size: 18, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.isHidden = true
        return label
    }()
    
    // MARK: Interfacae properties
    
    var message: String? {
        get { messageLabel.text }
        set {
            messageLabel.isHidden = false
            messageLabel.text = newValue
        }
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
            typeOfExerciseLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            typeOfExerciseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            timeOfExerciseLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            timeOfExerciseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            nameOfExerciseLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameOfExerciseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameOfExerciseLabel.topAnchor.constraint(equalTo: timeOfExerciseLabel.bottomAnchor, constant: 12),
            nameOfExerciseLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.isHidden = true
    }
    
    // MARK: Configuration method
    
    private func configure() {
        backgroundColor = nil
        contentView.backgroundColor = nil
        selectionStyle = .none
        
        contentView.addSubview(typeOfExerciseLabel)
        contentView.addSubview(timeOfExerciseLabel)
        contentView.addSubview(nameOfExerciseLabel)
        contentView.addSubview(messageLabel)
    }
    
    // MARK: Interface methods
    
    func set(_ viewModel: Exercise?) {
        guard let viewModel = viewModel else {
            messageLabel.text = "Нет пары"
            messageLabel.isHidden = false
            return
        }
        
        typeOfExerciseLabel.text = viewModel.type
        timeOfExerciseLabel.text = viewModel.pair
        nameOfExerciseLabel.text = viewModel.name
        
        layoutIfNeeded()
    }
    
}
