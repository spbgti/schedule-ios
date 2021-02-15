import UIKit

class ScheduleViewController: UIViewController {
    
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = nil
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: "\(ExerciseTableViewCell.self)")
        tableView.register(EmptyExerciseTableViewCell.self, forCellReuseIdentifier: "\(EmptyExerciseTableViewCell.self)")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        return tableView
    }()
    
    // MARK: Properties
    
    private let scheduleService: SchedulesService
    
    let roomService: RoomsService
    
    private var group: Group?
    
    private var baseDate: Date
    
    var semester: AcademicSemester {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: baseDate)
        
        switch month {
        case (1...8):
            return .spring
            
        default:
            return .fall
        }
    }
    
    // MARK: Data source variables
    
    // Data source of exercise objects
    var exercises: [Exercise]?
    
    // Data source of exercise time objects
    
    var exerciseTime: [ExerciseTime]?
    
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
        self.roomService = RoomsService()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getExerciseTime()
        setTitle()
    }
    
    // MARK: Method to fetch Schedule model
    
    private func getExerciseTime() {
        let assets = NSDataAsset(name: "ExerciseTime", bundle: Bundle.main)
        if let data = assets?.data {
            do {
                exerciseTime = try JSONDecoder().decode([ExerciseTime].self, from: data)
                getSchedule()
            } catch {
                print("Can't decode a json data from Data.assets")
            }
        } else {
            print("Can't found a data from the assets with name 'ExerciseTime'")
        }
    }
    
    private func getSchedule() {
        guard let group = group else { return }
// FIXME: test data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let date = dateFormatter.date(from: "2019")!
        
        scheduleService.getSchedules(year: date,
                                     semester: semester,
                                     groupNumber: group.number) { [weak self] result in
            switch result {
            case let .success(schedules):
                guard schedules.count > 0 else {
// TODO: display error on UILabel
                    print("No data")
                    return
                }
                self?.exercises = schedules[0].exercises
                self?.tableView.reloadData()
                
            case let .failure(error):
// TODO: display error on UILabel
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Helper methods
    
    private func setTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        let date = dateFormatter.string(from: baseDate)
        let semester = self.semester == .fall ? "Осень" : "Весна"
        
        title = "\(semester), \(date)"
    }
  
}
