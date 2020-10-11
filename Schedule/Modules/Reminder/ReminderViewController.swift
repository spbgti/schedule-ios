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
    
    private var detailsTransitioningDelegate: InteractiveModalTransitioningDelegate!
    private var reminders: [Reminder]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateReminders()
        collectionView.reloadData()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ReminderCVCell", bundle: nil), forCellWithReuseIdentifier: "ReminderCVCell")
    }
    
    private func generateReminders() {
        if let morningReminder = UserDefaults.standard.object(forKey: "Morning reminder") as? Data {
            let reminder = try! JSONDecoder().decode(Reminder.self, from: morningReminder)
            reminders = [reminder]
        }
        
        if let eveningReminder = UserDefaults.standard.object(forKey: "Evening reminder") as? Data {
            let reminder = try! JSONDecoder().decode(Reminder.self, from: eveningReminder)
            reminders = [reminder]
        }
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
        let width: CGFloat = 270.0
        let height: CGFloat = 160.0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
}

extension ReminderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let reminder = self.reminders?[indexPath.row]
        
        let storyboard = UIStoryboard(name: "ReminderSettings", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! ReminderSettingsViewController
                
        detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self, to: controller)
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = detailsTransitioningDelegate
        controller.reminder = reminder
        
        controller.callback = { [weak self] updatedReminder in
            self?.reminders?[indexPath.row] = updatedReminder
            self?.collectionView.reloadData()
        }
        
        present(controller, animated: true, completion: nil)
    }
}
