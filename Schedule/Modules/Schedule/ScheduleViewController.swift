import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet private var segmentedControl: UISegmentedControl!
    @IBOutlet private var loading: UIActivityIndicatorView!
    @IBOutlet private var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = DataProvider.shared
        self.tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "scheduleCellIdentifier")
        self.tableView.rowHeight =  128.0

        self.segmentedControl.addTarget(self, action: #selector(changeIndex), for: .valueChanged)
        
        self.loading.startAnimating()
        DataProvider.shared.uploadDataByDay(by: "2019-09-21") { completion in
            if let error = completion {
                Alert.showMessageAlert(on: self, message: error, title: "Error")
            } else {
                self.tableView.reloadData()
            }
            self.loading.stopAnimating()
        }
    }

    @objc private func changeIndex() {
        loading.startAnimating()
        
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
          DataProvider.shared.uploadDataByDay(by: "2019-09-21") { completion in
            if let error = completion {
              Alert.showMessageAlert(on: self, message: error, title: "Error")
            }
            self.loading.stopAnimating()
            self.tableView.reloadData()
          }
        case 1:
          DataProvider.shared.uploadDataByDay(by: "2019-09-22") { completion in
            if let error = completion {
              Alert.showMessageAlert(on: self, message: error, title: "Error")
            }
            self.loading.stopAnimating()
            self.tableView.reloadData()
          }
        case 2:
          DataProvider.shared.uploadDataByYear(by: "2019") { completion in
            if let error = completion {
              Alert.showMessageAlert(on: self, message: error, title: "Error")
            }
            self.loading.stopAnimating()
            self.tableView.reloadData()
          }
        default:
          break
        }
    }
  
}
