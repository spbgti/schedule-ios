import UIKit

// MARK: - ViewController
class ViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var groupTextField: UITextField!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
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
  @IBAction func getResponse(_ sender: UIButton) {
    
    ScheduleRequest.shared.getGroups(groupName: self.groupTextField.text!) { completion in
      DispatchQueue.main.async {
        ScheduleRequest.shared.getExercises(groupId: String(completion[0].groupId), date: self.dateTextField.text!) { completionHandler in
          self.array = completionHandler
        }
      }
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
