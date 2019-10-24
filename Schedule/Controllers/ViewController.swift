import UIKit

// MARK: - ViewController
class ViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var selectedControl: UISegmentedControl!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - Public var and let
  let identifier = "Cell"
  var array = [Exercise]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK: - Life Cicle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: - IBActions
  @IBAction func indexChange(_ sender: Any) {
    activityIndicator.startAnimating()
    
    let userDefaults = UserDefaults.standard
    let groupName = userDefaults.string(forKey: "groupNameKey")
    
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

// MARK: - UITableViewDataSource and UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
  
  // MARK: - Count of sections
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  // MARK: - Setting of cell
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:CustomTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CustomTableViewCell
    
    let pair = array[indexPath.row].pair
    
    switch pair {
    case "1":
      cell.timeLabel?.text = "09:30 - 11:00"
    case "2":
      cell.timeLabel?.text = "11:30 - 13:00"
    case "3":
      cell.timeLabel?.text = "14:00 - 15:30"
    case "4":
      cell.timeLabel?.text = "16:00 - 17:30"
    default:
      break
    }
    
    cell.exerciseLabel?.text = array[indexPath.row].name
    
    return cell
  }
  
}

// MARK: CustomTableViewCell
class CustomTableViewCell: UITableViewCell {
  
  // Mark: - IBOutlet; items of the table cell
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var exerciseLabel: UILabel!
  
}
