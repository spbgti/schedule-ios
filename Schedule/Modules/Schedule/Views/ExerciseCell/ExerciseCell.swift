//
//  ExerciseCell.swift
//  schedule
//
//  Created by Vladislav Glumov on 13.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

final class ExerciseCell: UITableViewCell {
    
    // MARK: Interface builder outlet subviews
    
    @IBOutlet private var pairLabel: UILabel!
    
    @IBOutlet private var typeLabel: UILabel!
    
    @IBOutlet private var timeLabel: UILabel!
    
    @IBOutlet private var exerciseName: UILabel!
    
    @IBOutlet private var teacherLabel: UILabel!
    
    @IBOutlet private var roomLabel: UILabel!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        pairLabel.layer.cornerRadius = 13
        pairLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        pairLabel.text = nil
        typeLabel.text = nil
        timeLabel.text = nil
        exerciseName.text = nil
        teacherLabel.text = nil
        roomLabel.text = nil
    }
    
    // MARK: Prepare for reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        exerciseName.textAlignment = .left
        
        pairLabel.text = nil
        typeLabel.text = nil
        timeLabel.text = nil
        exerciseName.text = nil
        teacherLabel.text = nil
        roomLabel.text = nil
    }
    
    // MARK: Interface method
    
    func set(_ viewModel: ExerciseCellModel?) {
        if viewModel == nil {
            exerciseName.textAlignment = .center
            exerciseName.text = "Нет пары"
        } else {
            pairLabel.text = viewModel?.pair
            typeLabel.text = viewModel?.type
            timeLabel.text = viewModel?.time
            exerciseName.text = viewModel?.name
            teacherLabel.text = viewModel?.teachers
            roomLabel.text = viewModel?.location
        }
    }
    
}
