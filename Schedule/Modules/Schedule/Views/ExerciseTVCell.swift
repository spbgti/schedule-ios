//
//  ExerciseTVCell.swift
//  schedule
//
//  Created by Vladislav Glumov on 13.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

final class ExerciseTVCell: UITableViewCell {
    
    // MARK: Subviews
    
    private lazy var pairLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 14, weight: .light)
        label.textColor = UIColor(red: 123 / 255, green: 128 / 255, blue: 134 / 255, alpha: 1)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 13
        label.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        label.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 14, weight: .light)
        label.textColor = UIColor(red: 127 / 255, green: 130 / 255, blue: 135 / 255, alpha: 1)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 14, weight: .light)
        label.textColor = UIColor(red: 127 / 255, green: 130 / 255, blue: 135 / 255, alpha: 1)
        return label
    }()
    
    private lazy var exerciseName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 18, weight: .semibold)
        label.textColor = UIColor(red: 66 / 255, green: 66 / 255, blue: 66 / 255, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var teacherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 14, weight: .light)
        label.textColor = UIColor(red: 127 / 255, green: 130 / 255, blue: 135 / 255, alpha: 1)
        return label
    }()
    
    private lazy var roomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProText(size: 14, weight: .light)
        label.textColor = UIColor(red: 127 / 255, green: 130 / 255, blue: 135 / 255, alpha: 1)
        return label
    }()
    
    // MARK: Property interface
    
    var pair: String? {
        get { pairLabel.text }
        set { pairLabel.text = newValue }
    }
    
    var type: String? {
        get { typeLabel.text }
        set { typeLabel.text = newValue }
    }
    
    var time: String? {
        get { timeLabel.text }
        set { timeLabel.text = newValue }
    }
    
    var name: String? {
        get { exerciseName.text }
        set { exerciseName.text = newValue }
    }
    
    var teacher: String? {
        get { teacherLabel.text }
        set { teacherLabel.text = newValue}
    }
    
    var room: String? {
        get { roomLabel.text }
        set { roomLabel.text = newValue}
    }
    
    // MARK: Initialization
    
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
            pairLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            pairLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pairLabel.widthAnchor.constraint(equalToConstant: 23),
            pairLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        NSLayoutConstraint.activate([
            typeLabel.centerYAnchor.constraint(equalTo: pairLabel.centerYAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: pairLabel.trailingAnchor, constant: 9)
        ])

        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: pairLabel.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9)
        ])
        
        NSLayoutConstraint.activate([
            exerciseName.topAnchor.constraint(equalTo: pairLabel.bottomAnchor, constant: 18),
            exerciseName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            exerciseName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9)
        ])
        
        NSLayoutConstraint.activate([
            teacherLabel.topAnchor.constraint(equalTo: exerciseName.bottomAnchor, constant: 4),
            teacherLabel.leadingAnchor.constraint(equalTo: exerciseName.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            roomLabel.topAnchor.constraint(equalTo: teacherLabel.bottomAnchor, constant: 16),
            roomLabel.leadingAnchor.constraint(equalTo: teacherLabel.leadingAnchor),
            roomLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22)
        ])
    }
    
    // MARK: Prepare for reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        exerciseName.textAlignment = .left
        pairLabel.text = nil
        typeLabel.text = nil
        timeLabel.text = nil
        exerciseName.text = nil
    }
    
    // MARK: Configuration
    
    private func configure() {
        contentView.addSubview(pairLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(exerciseName)
        contentView.addSubview(teacherLabel)
        contentView.addSubview(roomLabel)
    }
    
    // MARK: Interface method
    
    func set(_ viewModel: Exercise?) {
        if viewModel == nil {
            exerciseName.textAlignment = .center
            exerciseName.text = "Нет пары"
        } else {
            typeLabel.text = viewModel?.type
            timeLabel.text = viewModel?.pair
            exerciseName.text = viewModel?.name.capitalizingFirstLetter()
        }
    }
    
}
