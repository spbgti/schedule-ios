import UIKit

class ViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: Public var and let
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
    
    DispatchQueue.main.async {
      // reload data in tableView
      //self.tableView.reloadData()
      
      // call method getGroups
      APIManager.shared.getExercises { [weak self] completion in
        switch completion {
        case .failure(let error):
          if error == .noDataAvailable {
            print("noDataAvailable")
          } else {
            print("canNotProccessData")
          }
        case .success(let result):
          self?.array = result
        }
      }
    }
    
  }
  
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: indetifier, for: indexPath)
    
    cell.textLabel?.text = array[indexPath.row].name
    
    return cell
  }
  
}
