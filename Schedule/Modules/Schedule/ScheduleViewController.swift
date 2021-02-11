import UIKit

class ScheduleViewController: UIViewController {
    
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = nil
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getSchedule()
    }
    
    // MARK: Method to fetch Schedule model
    
    private func getSchedule() {
        guard let group = group else { return }
// FIXME: test data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let date = dateFormatter.date(from: "2019")!
        
        scheduleService.getSchedules(year: date,
// TODO: create func to define a semester
                                     semester: .fall,
                                     groupNumber: group.number) { [weak self] result in
            switch result {
            case let .success(schedules):
                guard schedules.count > 0 else {
// TODO: display error on UILabel
                    print("No data")
                    return
                }
                self?.dataSource = schedules[0].exercises
                
            case let .failure(error):
// TODO: display error on UILabel
                print(error.localizedDescription)
            }
        }
    }
  
}

extension ScheduleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
