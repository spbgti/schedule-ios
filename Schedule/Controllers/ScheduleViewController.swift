import UIKit
import PureLayout

class ScheduleViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  // MARK: - Views
  
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = UIColor.systemBlue
    refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    return refreshControl
  }()
  
  lazy var activityIndicator: UIActivityIndicatorView = {
    let activityControl = UIActivityIndicatorView()
    activityControl.hidesWhenStopped = true
    activityControl.style = .large
    activityControl.color = .blue
    return activityControl
  }()
  
  func addConstraints() {
    // ActivityIndicatorView constraints
    activityIndicator.autoAlignAxis(toSuperviewAxis: .vertical)
    activityIndicator.autoAlignAxis(toSuperviewAxis: .horizontal)
  }
  
  // MARK: - Properties
  
  let today = Date.today
  let tomorrow = Date.tomorrow
  let year = Date.year
  let userDefaults = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")
  var sortedExercises = [WeekDaySection: [Exercise]]()
  var exercises = [Exercise]() {
    didSet {
      self.sortData()
      DispatchQueue.main.async {
        self.tableView.reloadData()
        self.activityIndicator.stopAnimating()
        self.tableView.isHidden = false
      }
    }
  }
  
  // MARK: - Life Cicle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.addSubview(refreshControl)
    self.view.addSubview(activityIndicator)
    
    addConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    let groupName = self.userDefaults?.string(forKey: "groupNameKey")
    
    segmentedControl.selectedSegmentIndex = 0
    activityIndicator.startAnimating()
    
    DataManager.shared.getExercisesByGroupName(groupName: groupName!, date: "2019-09-22") { completionHandler in
      DispatchQueue.main.async {
        switch completionHandler {
        case .success(let result):
          self.exercises = result
        case .failure(let error):
          self.activityIndicator.stopAnimating()
          Alert.showBasicAlert(on: self, message: error, with: "Unable to retrieve data")
        }
      }
    }
  }
  
  // MARK: - IBActions
  
  @IBAction func selectSchedule(_ sender: Any) {
    let groupName = self.userDefaults?.string(forKey: "groupNameKey")
    
    tableView.isHidden = true
    activityIndicator.startAnimating()
    
    switch segmentedControl.selectedSegmentIndex {
    case 0:
      DataManager.shared.getExercisesByGroupName(groupName: groupName!, date: "2019-09-22") { completionHandler in
        DispatchQueue.main.async {
          switch completionHandler {
          case .success(let result):
            self.exercises = result
          case .failure(let error):
            Alert.showBasicAlert(on: self, message: error, with: "Unable to retrieve data")
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
            Alert.showBasicAlert(on: self, message: error, with: "Unable to retrieve data")
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
            Alert.showBasicAlert(on: self, message: error, with: "Unable to retrieve data")
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
  
  // MARK: - @objc functions
  
  @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    let cache = URLCache.shared
    cache.removeAllCachedResponses()
    
    // TODO: - Remove cache for selectedControl.index, if no internet
    DispatchQueue.main.async {
      refreshControl.endRefreshing()
    }
  }
  
}
