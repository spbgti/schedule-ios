//
//  ScheduleTableViewStructure.swift
//  schedule
//
//  Created by Vladislav Glumov on 16.02.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

// MARK: ScheduleTableViewSection

enum Weekday: String {
    case monday = "Понедельник"
    case tuesday = "Вторник"
    case wednesday = "Среда"
    case thursday = "Четверг"
    case friday = "Пятница"
    case saturday = "Суботта"
    case sunday = "Воскресенье"
}

extension Weekday: CaseIterable {}

// MARK: ScheduleTableViewItem

enum ExerciseNumber {
    case first, second, third, fourth, fivth
}

extension ExerciseNumber: CaseIterable {}
