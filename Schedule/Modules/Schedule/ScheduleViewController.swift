import UIKit

final class ScheduleViewController: UIViewController {
    
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = nil
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExerciseTableViewCell.self,
                           forCellReuseIdentifier: "\(ExerciseTableViewCell.self)")
        tableView.register(EmptyExerciseTableViewCell.self,
                           forCellReuseIdentifier: "\(EmptyExerciseTableViewCell.self)")
        tableView.register(ScheduleTableViewSectionHeader.self,
                           forHeaderFooterViewReuseIdentifier: "\(ScheduleTableViewSectionHeader.self)")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 40
        return tableView
    }()
    
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.SFProText(size: 16, weight: .regular)
        return label
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
    
    var dataSource: [ScheduleTableViewSection : [Exercise]?]?
    
    // Data source of exercise objects
    var exercises: [Exercise]?
    
    // Data source of exercise time objects
    
    var exerciseTime: [ExerciseTime]?
    
    // Data source of exercise room
    
    var exerciseRoom: [Room?]?
    
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
        
        configure()
        layoutOfSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getExerciseTime()
        setTitle()
    }
    
    // MARK: Configuration
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(errorMessageLabel)
    }
    
    // MARK: Layout of subviews
    
    private func layoutOfSubviews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorMessageLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            errorMessageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
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
            case let .success(schedule):
                let exercises = schedule[0].exercises
                guard exercises.count > 0 else {
                    self?.errorMessageLabel.text = "Расписание не найдено"
                    return
                }
                
                self?.filter(exercises)
                self?.exercises = exercises
                self?.tableView.reloadData()
                
            case let .failure(error):
                self?.errorMessageLabel.text = error.localizedDescription
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
    
    private func filter(_ data: [Exercise]) {
        dataSource = [:]
        
        dataSource?[.monday] = data.filter { $0.day == "1" }
        dataSource?[.tuesday] = data.filter { $0.day == "2" }
        dataSource?[.wednesday] = data.filter { $0.day == "3" }
        dataSource?[.thursday] = data.filter { $0.day == "4" }
        dataSource?[.friday] = data.filter { $0.day == "5" }
        dataSource?[.saturday] = data.filter { $0.day == "6" }
    }
  
}
