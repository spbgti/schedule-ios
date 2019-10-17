import UIKit

// MARK: - ViewController
class ViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var selectedControl: UISegmentedControl!
  
  // MARK: - Public var and let
  
  let indetifier = "Cell"
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
    switch selectedControl.selectedSegmentIndex {
    case 0:
      ScheduleRequest.shared.getGroups(groupName: "446") { completion in
        DispatchQueue.main.async {
          ScheduleRequest.shared.getExercises(groupId: String(completion[0].groupId), date: "2019-09-22") { completionHandler in
            self.array = completionHandler
          }
        }
      }
    case 1:
      ScheduleRequest.shared.getGroups(groupName: "446") { completion in
        DispatchQueue.main.async {
          ScheduleRequest.shared.getExercises(groupId: String(completion[0].groupId), date: "2019-09-23") { completionHandler in
            self.array = completionHandler
          }
        }
      }
    case 2:
      ScheduleRequest.shared.getSchedules(year: "2019", groupNumber: "446") { completion in
        DispatchQueue.main.async {
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
    let cell = tableView.dequeueReusableCell(withIdentifier: indetifier, for: indexPath)
    
    cell.textLabel?.text = array[indexPath.row].name
    
    return cell
  }
  
}
