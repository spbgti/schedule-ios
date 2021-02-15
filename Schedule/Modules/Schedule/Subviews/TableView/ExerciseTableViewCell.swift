//
//  ExerciseTableViewCell.swift
//  schedule
//
//  Created by Vladislav Glumov on 11.02.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    // MARK: Wrapping subviews
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var firstLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var teachersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        return stackView
    }()
    
    // MARK: Subviews
    
    private lazy var typeOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 253), for: .vertical)
        label.textAlignment = .left
        label.font = UIFont.SFProText(size: 14, weight: .medium)
        label.textColor = UIColor(red: 133 / 255, green: 133 / 255, blue: 133 / 255, alpha: 1)
        return label
    }()
    
    private lazy var timeOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 253), for: .vertical)
        label.textAlignment = .right
        label.font = UIFont.SFProText(size: 14, weight: .medium)
        label.textColor = UIColor(red: 133 / 255, green: 133 / 255, blue: 133 / 255, alpha: 1)
        return label
    }()
    
    private lazy var nameOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = bounds.size.width
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.SFProDisplay(size: 18, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var placeOfExerciseLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 253), for: .vertical)
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

    var teacher: [String] {
        get { [] }
        set { fillTeacherStackView(newValue) }
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contentStackViewTopAnchor = contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
        contentStackViewTopAnchor.isActive = true
        contentStackViewTopAnchor.priority = UILayoutPriority(999)
        
        let contentStackViewLeadingAnchor = contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        contentStackViewLeadingAnchor.isActive = true
        
        let contentStackViewTrailingAnchor = contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        contentStackViewTrailingAnchor.isActive = true
        
        let contentStackViewBottomAnchor = contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        contentStackViewBottomAnchor.isActive = true
        contentStackViewBottomAnchor.priority = UILayoutPriority(999)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        teachersStackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    // MARK: Configuration method
    
    private func configure() {
        backgroundColor = nil
        contentView.backgroundColor = nil
        contentView.addSubview(contentStackView)
        
        firstLineStackView.addArrangedSubview(typeOfExerciseLabel)
        firstLineStackView.addArrangedSubview(timeOfExerciseLabel)
        
        contentStackView.addArrangedSubview(firstLineStackView)
        contentStackView.addArrangedSubview(nameOfExerciseLabel)
        contentStackView.addArrangedSubview(teachersStackView)
        contentStackView.addArrangedSubview(placeOfExerciseLabel)
    }
    
    // MARK: Fill a teacher stack view
    
    private func fillTeacherStackView(_ array: [String]) {
        guard array.count > 0 else {
            let label = createTeacherLabel(with: "Состав преподавателей уточните на кафедре")
            teachersStackView.addArrangedSubview(label)
            return
        }
        
        array.forEach { [weak self] string in
            let label = createTeacherLabel(with: string)
            self?.teachersStackView.addArrangedSubview(label)
        }
    }
    
    private func createTeacherLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 253), for: .vertical)
        label.numberOfLines = 0
        label.font = UIFont.SFProText(size: 14, weight: .regular)
        label.textColor = UIColor(red: 133 / 255, green: 133 / 255, blue: 133 / 255, alpha: 1)
        label.text = text
        return label
    }
    
}
