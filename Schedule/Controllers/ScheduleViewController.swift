import UIKit
import PureLayout

class ScheduleViewController: UIViewController {
  
  // MARK: - Life Cicle
  
  override func loadView() {
    self.view = ScheduleView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view().backgroundColor = UIColor.white
    title = "Main"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Setting", style: .plain, target: self, action: #selector(switchToSettingView))
    
    self.view().tableView.dataSource = DataProvider.shared
    self.view().tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "scheduleCellIdentifier")
    
    view().segmentedControl.addTarget(self, action: #selector(changeIndex), for: .valueChanged)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
    DataProvider.shared.uploadDataByDay(by: "2019-09-21") { completion in
      DispatchQueue.main.async {
        if let error = completion {
          Alert.showMessageAlert(on: self, message: error, title: "Error")
        } else {
          self.view().tableView.reloadData()
        }
      }
    }
  }
  
  // MARK: Methods
  
  func view() -> ScheduleView {
    return self.view as! ScheduleView
  }
  
  // MARK: @objc Methods
  
  @objc func switchToSettingView() {
    navigationController?.pushViewController(SettingTableViewController(), animated: true)
  }
  
  @objc func changeIndex() {
    switch self.view().segmentedControl.selectedSegmentIndex {
    case 0:
      DataProvider.shared.uploadDataByDay(by: "2019-09-21") { completion in
        DispatchQueue.main.async {
          if let error = completion {
            Alert.showMessageAlert(on: self, message: error, title: "Error")
          }
          self.view().tableView.reloadData()
        }
      }
    case 1:
      DataProvider.shared.uploadDataByDay(by: "2019-09-22") { completion in
        DispatchQueue.main.async {
          if let error = completion {
            Alert.showMessageAlert(on: self, message: error, title: "Error")
          }
          self.view().tableView.reloadData()
        }
      }
    case 2:
      DataProvider.shared.uploadDataByYear(by: "2019") { completion in
        DispatchQueue.main.async {
          if let error = completion {
            Alert.showMessageAlert(on: self, message: error, title: "Error")
          }
          self.view().tableView.reloadData()
        }
      }
    default:
      break
    }
  }
  
}
