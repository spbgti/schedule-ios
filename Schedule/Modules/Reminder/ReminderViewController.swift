//
//  NotificationSettingTableViewController.swift
//  schedule
//
//  Created by vladislav on 19.11.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private var reminders: [Reminder]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateReminders()
        collectionView.reloadData()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ReminderCVCell", bundle: nil), forCellWithReuseIdentifier: "ReminderCVCell")
    }
    
    // TODO: delete functions, use only for test
    private func generateReminders() {
        let eveningReminder = Reminder(name: "Evening reminder",
                                       icon: UIImage(systemName: "moon.fill")!,
                                       description: nil,
                                       time: "19:30",
                                       isRepeate: true,
                                       isActive: true)
        let morningReminder = Reminder(name: "Morning reminder",
                                       icon: UIImage(systemName: "sun.max.fill")!,
                                       description: nil,
                                       time: "07:00",
                                       isRepeate: false,
                                       isActive: false)
        reminders = [eveningReminder, morningReminder]
    }
    
}

extension ReminderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (reminders?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reminder = reminders?[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderCVCell", for: indexPath) as! ReminderCVCell
        cell.set(reminder!)
        
        return cell
    }
}

extension ReminderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 36
        let height = UIScreen.main.bounds.height / 3
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

extension ReminderViewController: UICollectionViewDelegate {
    
}
