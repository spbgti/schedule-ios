import UIKit

class ScheduleViewController: UIViewController {
    
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: Properties
    
    private let scheduleService: SchedulesService
    
    private var group: Group?
    
    private var baseDate: Date
    
    private var dataSource: [Exercise]?
    
    // MARK: Initialization
    
    init(baseDate: Date) {
        if let data = UserDefaults.standard.object(forKey: UserDefaults.Key.group) as? Data {
            do {
                self.group = try JSONDecoder().decode(Group.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        self.baseDate = baseDate
        self.scheduleService = SchedulesService()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
        
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getSchedule()
    }
    
    // MARK: Method to fetch Schedule model
    
    private func getSchedule() {
        guard let group = group else { return }
        
        scheduleService.getSchedules(year: baseDate,
                                     semester: .fall, // TODO: create func to define a semester
                                     groupNumber: group.number) { [weak self] result in
            switch result {
            case let .success(schedules):
                guard schedules.count > 0 else {
                    print("No data")
                }
                self?.dataSource = schedules[0].exercises
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
  
}

extension ScheduleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
