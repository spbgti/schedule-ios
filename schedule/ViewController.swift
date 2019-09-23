import UIKit

class ViewController: UIViewController {
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var label: UILabel!
  // MARK: - Life Cicle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    APIManager.shared.getGroups { [weak self] completion in
      DispatchQueue.main.async {
        switch completion {
        case .failure(let error):
          print(error)
        case .success(let groups):
          self?.label.text = groups.number
        }
      }
    }
    
  }
  
}
