import UIKit

final class ScheduleViewController: UIViewController {
    
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        
        tableView.register(ExerciseTVCell.self, forCellReuseIdentifier: "ExerciseTVCell")
        tableView.register(DayOffTVCell.self, forCellReuseIdentifier: "DayOffTVCell")
        tableView.register(ScheduleTVSectionHeader.self, forHeaderFooterViewReuseIdentifier: "ScheduleTVSectionHeader")
        
        tableView.dataSource = viewModel
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 375
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    private lazy var tableHeaderView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 246 / 255, green: 248 / 255, blue: 247 / 255, alpha: 1)
        label.font = UIFont.SFProDisplay(size: 16, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = viewModel.tableHeaderView
        return label
    }()
    
// FIXME: handle touching without Exercise data (do not enable and reduce opacity)
    
    private lazy var parityControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ScheduleParity.allCases.map { $0.name })
        control.addTarget(self, action: #selector(switchParity(_:)), for: .valueChanged)
        return control
    }()
    
    private lazy var errorLabel: ErrorLabel = {
        let label = ErrorLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var activityIndicator: ActivityIndicator = {
        let activityIndicator = ActivityIndicator()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    
    // MARK: Dependency properties
    
    private var viewModel = ScheduleViewModel()
    
    
    // MARK: Initializators
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewModel.callback = { [weak self] error in
            if let error = error {
                self?.errorLabel.isHidden = false
                self?.errorLabel.title = "Ошибка"
                self?.errorLabel.text = error
            } else {
                self?.errorLabel.isHidden = true
                self?.tableView.reloadData()
            }
            
            self?.activityIndicator.stopAnimating()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        viewModel.getGroup()
    }
    
    // MARK: Layout subviews
    
    private func layoutSubviews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tableHeaderView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableHeaderView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            tableHeaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableHeaderView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: Configuration
    
    private func configure() {
        parityControl.selectedSegmentIndex = 0
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 246 / 255, green: 248 / 255, blue: 247 / 255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.titleView = parityControl
        
        errorLabel.isHidden = true
        
        view.addSubview(tableHeaderView)
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
    }
    
    // MARK: Target-action methods
    
    @objc
    private func switchParity(_ sender: UISegmentedControl) {
        viewModel.switchParity(ScheduleParity.allCases[sender.selectedSegmentIndex])
    }
  
}

// MARK: UITableViewDelegate methods implementation

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ScheduleTVSectionHeader") as? ScheduleTVSectionHeader else {
            fatalError()
        }
        
        headerView.title = "\(ScheduleWeek.allCases[section].name)"
        
        return headerView
    }
}
