import UIKit

class MainViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var selectedControl: UISegmentedControl!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - Properties
  let userDefaults = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")
  var sortedExercises = [WeekDaySection: [Exercise]]()
  var exercises = [Exercise]() {
    didSet {
      self.sortData()
      self.tableView.reloadData()
      self.activityIndicator.stopAnimating()
      self.tableView.isHidden = false
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
          self.exercises = result
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
            self.exercises = result
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
            self.exercises = result
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
            self.exercises = result[0].exercises
          case .failure(let error):
            self.showErrorMessage(message: error)
          }
        }
      }
    default:
      break
    }
  }
  
  // MARK: - Sort data by day of the week
   private func sortData() {
     self.sortedExercises.removeAll()
     
     for exercise in exercises {
       switch exercise.day {
       case "1":
         sortedExercises[.monday] = exercises.filter({ $0.day == "1" })
       case "2":
         sortedExercises[.tuesday] = exercises.filter({ $0.day == "2" })
       case "3":
         sortedExercises[.wednesday] = exercises.filter({ $0.day == "3" })
       case "4":
         sortedExercises[.thursday] = exercises.filter({ $0.day == "4" })
       case "5":
         sortedExercises[.friday] = exercises.filter({ $0.day == "5" })
       case "6":
         sortedExercises[.saturday] = exercises.filter({ $0.day == "6" })
       case "7":
         sortedExercises[.sunday] = exercises.filter({ $0.day == "7" })
       default:
         break
       }
     }
   }
  
  // MARK: - UIAllertController
  func showErrorMessage(message: String) {
    let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    
    alertController.addAction(okAction)
    self.present(alertController, animated: true)
  }
  
}
