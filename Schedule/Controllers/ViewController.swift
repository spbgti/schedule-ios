import UIKit

// MARK: - ViewController
class ViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var selectedControl: UISegmentedControl!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - Public var and let
  
  let userDefaults = UserDefaults.standard
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
    
    selectedControl.selectedSegmentIndex = 0
    let groupName = self.userDefaults.string(forKey: "groupNameKey")
    activityIndicator.startAnimating()
    
    if groupName == "446" {
      ScheduleRequest.shared.getGroups(groupName: groupName!) { completion in
        DispatchQueue.main.async {
          ScheduleRequest.shared.getExercises(groupId: String(completion[0].groupId), date: "2019-09-22") { completionHandler in
            self.activityIndicator.stopAnimating()
            self.array = completionHandler
            print(self.array[0].day)
            print(self.data.count)
          }
        }
      }
    }
  }
  
  // sort data by day of the week
  private func sortData() {
    data[.monday] = array.filter({ $0.day == "1" })
    data[.tuesday] = array.filter({ $0.day == "2" })
    data[.wednesday] = array.filter({ $0.day == "3" })
    data[.thursday] = array.filter({ $0.day == "4" })
    data[.friday] = array.filter({ $0.day == "5" })
    data[.saturday] = array.filter({ $0.day == "6" })
    data[.sunday] = array.filter({ $0.day == "7" })
  }
  
  // MARK: - IBActions
  @IBAction func indexChange(_ sender: Any) {
    activityIndicator.startAnimating()
    let groupName = self.userDefaults.string(forKey: "groupNameKey")
    
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