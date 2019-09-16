import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var label: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after     loading the view.
  }
  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    
    completionHandler(NCUpdateResult.newData)
    
    APIManager.shared.getGroup { completion in
      DispatchQueue.main.async {
        self.label.text = completion
      }
    }
    
  }
  
}
