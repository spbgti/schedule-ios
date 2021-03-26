//
//  ExerciseTVCell.swift
//  schedule
//
//  Created by Vladislav Glumov on 13.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

final class ExerciseTVCell: UITableViewCell {
    
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
    }
    
    // MARK: Prepare for reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        exerciseName.textAlignment = .left
        room = "Аудитория:"
    }
    
    // MARK: Interface method
    
    func set(_ viewModel: Exercise?) {
        if viewModel == nil {
            exerciseName.textAlignment = .center
            exerciseName.text = "Нет пары"
            typeLabel.text = nil
            room = nil
        } else {
            typeLabel.text = viewModel?.type
            exerciseName.text = viewModel?.name.capitalizingFirstLetter()
        }
    }
    
    var roomService = RoomsService()
    
    var cache: [Int : Room] = [:]
    
    func setRoom(_ id: Int) {
        if let room = cache[id] {
            self.room = "Аудитория: \(room.name)"
        }
        
        roomService.getRoom(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let room):
                    self?.cache[id] = room
                    self?.room = "Аудитория: \(room.name)"
                    
                case .failure(_):
                    self?.room = "Аудитория: undefind"
                }
            }
        }
    }
    
}
