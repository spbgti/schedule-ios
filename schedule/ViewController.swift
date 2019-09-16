import UIKit

class ViewController: UIViewController {
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var label: UILabel!
  
  // MARK: - Life Cicle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    APIManager.shared.getGroup { completion in
      DispatchQueue.main.async {
        self.label.text = completion
      }
    }
  }
  
}
