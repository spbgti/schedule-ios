//
//  ExerciseTableViewCell.swift
//  schedule
//
//  Created by Vladislav Glumov on 11.02.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    // MARK: Subviews
    
    private lazy var typeOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 14, weight: .medium)
        label.textColor = UIColor(red: 133 / 255, green: 133 / 255, blue: 133 / 255, alpha: 1)
        return label
    }()
    
    private lazy var timeOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 14, weight: .medium)
        label.textColor = UIColor(red: 133 / 255, green: 133 / 255, blue: 133 / 255, alpha: 1)
        return label
    }()
    
    private lazy var nameOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProDisplay(size: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
// TODO: create a UIStackView of labels
    private lazy var teacherOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 14, weight: .regular)
        label.textColor = UIColor(red: 133 / 255, green: 133 / 255, blue: 133 / 255, alpha: 1)
        return label
    }()
    
    private lazy var placeOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 14, weight: .regular)
        label.textColor = UIColor(red: 133 / 255, green: 133 / 255, blue: 133 / 255, alpha: 1)
        return label
    }()
    
    // MARK: Interface
    
    var type: String? {
        get { typeOfExerciseLabel.text }
        set { typeOfExerciseLabel.text = newValue }
    }
    
    var time: String? {
        get { timeOfExerciseLabel.text }
        set { timeOfExerciseLabel.text = newValue }
    }
    
    var name: String? {
        get { nameOfExerciseLabel.text }
        set { nameOfExerciseLabel.text = newValue }
    }

// TODO: change type to [String?]? or [String?]
    var teacher: String? {
        get { teacherOfExerciseLabel.text }
        set { teacherOfExerciseLabel.text = newValue}
    }
    
    var place: String? {
        get { placeOfExerciseLabel.text }
        set { placeOfExerciseLabel.text = newValue }
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
    
// FIXME: fix all warning of layout
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            typeOfExerciseLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            typeOfExerciseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            timeOfExerciseLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            timeOfExerciseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            nameOfExerciseLabel.topAnchor.constraint(equalTo: typeOfExerciseLabel.bottomAnchor, constant: 12),
            nameOfExerciseLabel.leadingAnchor.constraint(equalTo: typeOfExerciseLabel.leadingAnchor),
            nameOfExerciseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            teacherOfExerciseLabel.topAnchor.constraint(equalTo: nameOfExerciseLabel.bottomAnchor, constant: 8),
            teacherOfExerciseLabel.leadingAnchor.constraint(equalTo: nameOfExerciseLabel.leadingAnchor),
            
            placeOfExerciseLabel.topAnchor.constraint(equalTo: teacherOfExerciseLabel.bottomAnchor, constant: 22),
            placeOfExerciseLabel.leadingAnchor.constraint(equalTo: teacherOfExerciseLabel.leadingAnchor),
            placeOfExerciseLabel.trailingAnchor.constraint(equalTo: timeOfExerciseLabel.trailingAnchor),
            placeOfExerciseLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18)
        ])
    }
    
    // MARK: Configuration method
    
    private func configure() {
        backgroundColor = nil
        contentView.backgroundColor = nil
        
        contentView.addSubview(typeOfExerciseLabel)
        contentView.addSubview(timeOfExerciseLabel)
        contentView.addSubview(nameOfExerciseLabel)
        contentView.addSubview(teacherOfExerciseLabel)
        contentView.addSubview(placeOfExerciseLabel)
    }
    
}
