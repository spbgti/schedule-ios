import UIKit

// MARK: - ViewController
class MainViewController: UIViewController {
  
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
        self.activityIndicator.stopAnimating()
        self.tableView.isHidden = false
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
    
    DataManager.shared.getExercisesByGroupName(groupName: groupName!, date: "2019-09-22") { completionHandler in
      DispatchQueue.main.async {
        switch completionHandler {
        case .success(let result):
          self.array = result
        case .failure(let error):
          self.activityIndicator.stopAnimating()
          self.showErrorMessage(message: error)
        }
      }
    }
  }
  
  // MARK: - IBActions
  @IBAction func selectSchedule(_ sender: Any) {
    let groupName = self.userDefaults?.string(forKey: "groupNameKey")
    
    tableView.isHidden = true
    activityIndicator.startAnimating()
    
    switch selectedControl.selectedSegmentIndex {
    case 0:
      DataManager.shared.getExercisesByGroupName(groupName: groupName!, date: "2019-09-22") { completionHandler in
        DispatchQueue.main.async {
          switch completionHandler {
          case .success(let result):
            self.array = result
          case .failure(let error):
            self.showErrorMessage(message: error)
          }
        }
      }
    case 1:
      DataManager.shared.getExercisesByGroupName(groupName: groupName!, date: "2019-09-23") { completionHandler in
        DispatchQueue.main.async {
          switch completionHandler {
          case .success(let result):
            self.array = result
          case .failure(let error):
            self.showErrorMessage(message: error)
          }
        }
      }
    case 2:
      DataManager.shared.getSchedules(year: "2019", groupNumber: groupName!) { completion in
        DispatchQueue.main.async {
          switch completion {
          case .success(let result):
            self.array = result[0].exercises
          case .failure(let error):
            self.showErrorMessage(message: error)
          }
        }
      }
    default:
      break
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
  
  // UIAllertController
  func showErrorMessage(message: String) {
    let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(okAction)
    self.present(alertController, animated: true)
  }
  
}
