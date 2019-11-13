import UIKit

// MARK: - ViewController
class ViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var selectedControl: UISegmentedControl!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - Properties
  let userDefaults = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")
  var data = [TableSection: [Exercise]]()
  var array = [Exercise]() {
    didSet {
      DispatchQueue.main.async {
        self.sortData()
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK: - Life Cicle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    let groupName = self.userDefaults?.string(forKey: "groupNameKey")
    
    selectedControl.selectedSegmentIndex = 0
    activityIndicator.startAnimating()
    
    if groupName == "446" {
      ScheduleRequest.shared.getGroups(groupName: groupName!) { completion in
        DispatchQueue.main.async {
          ScheduleRequest.shared.getExercises(groupId: String(completion[0].groupId), date: "2019-09-22") { completionHandler in
            self.activityIndicator.stopAnimating()
            self.array = completionHandler
          }
        }
      }
    }
  }
  
  // sort data by day of the week
  private func sortData() {
    self.data.removeAll()
    
    for exercise in array {
      switch exercise.day {
      case "1":
        data[.monday] = array.filter({ $0.day == "1" })
      case "2":
        data[.tuesday] = array.filter({ $0.day == "2" })
      case "3":
        data[.wednesday] = array.filter({ $0.day == "3" })
      case "4":
        data[.thursday] = array.filter({ $0.day == "4" })
      case "5":
        data[.friday] = array.filter({ $0.day == "5" })
      case "6":
        data[.saturday] = array.filter({ $0.day == "6" })
      case "7":
        data[.sunday] = array.filter({ $0.day == "7" })
      default:
        break
      }
    }
  }
  
  // MARK: - IBActions
  @IBAction func selectSchedule(_ sender: Any) {
    let groupName = self.userDefaults?.string(forKey: "groupNameKey")
    
    activityIndicator.startAnimating()
    
    switch selectedControl.selectedSegmentIndex {
    case 0:
      ScheduleRequest.shared.getGroups(groupName: groupName!) { completion in
        DispatchQueue.main.async {
          ScheduleRequest.shared.getExercises(groupId: String(completion[0].groupId), date: "2019-09-22") { completionHandler in
            self.activityIndicator.stopAnimating()
            self.array = completionHandler
          }
        }
      }
    case 1:
      ScheduleRequest.shared.getGroups(groupName: groupName!) { completion in
        DispatchQueue.main.async {
          ScheduleRequest.shared.getExercises(groupId: String(completion[0].groupId), date: "2019-09-23") { completionHandler in
            self.activityIndicator.stopAnimating()
            self.array = completionHandler
          }
        }
      }
    case 2:
      ScheduleRequest.shared.getSchedules(year: "2019", groupNumber: groupName!) { completion in
        DispatchQueue.main.async {
          self.activityIndicator.stopAnimating()
          self.array = completion[0].exercises
        }
      }
    default:
      break
    }
  }
  
}
