import UIKit

final class ScheduleViewController: UIViewController {
    
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        
        tableView.register(UINib(nibName: "ExerciseTableViewCell", bundle: nil), forCellReuseIdentifier: "ExerciseTVCell")
        tableView.register(DayOffTVCell.self, forCellReuseIdentifier: "DayOffTVCell")
        tableView.register(ScheduleTVSectionHeader.self, forHeaderFooterViewReuseIdentifier: "ScheduleTVSectionHeader")
        
        tableView.dataSource = viewModel
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 220
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 32
        
        tableView.sectionFooterHeight = 0
        
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
// FIXME: handle touching without Exercise data (do not enable and reduce opacity)
    
    private lazy var parityControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ScheduleParity.allCases.map { $0.name })
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(switchParity(_:)), for: .valueChanged)
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private lazy var errorLabel: ErrorLabel = {
        let label = ErrorLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private lazy var activityIndicator: ActivityIndicator = {
        let activityIndicator = ActivityIndicator()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: Dependency properties
    
    private let viewModel: ScheduleViewModel
    
    // MARK: Initializators
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        viewModel.errorCallback = { [weak self] error in
            if let error = error {
                self?.errorLabel.isHidden = false
                self?.errorLabel.title = error.title
                self?.errorLabel.text = error.description
            } else {
                self?.errorLabel.isHidden = true
            }
        }
        
        viewModel.loaderCallback = { [weak self] isLoading in
            if isLoading {
                self?.parityControl.isEnabled = false
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.dataCallback = { [weak self] in
            self?.parityControl.isEnabled = true
            self?.tableView.reloadData()
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
        
        viewModel.viewDidLoad()
    }
    
    // MARK: Layout subviews
    
    private func layoutSubviews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            parityControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            parityControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            parityControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            parityControl.heightAnchor.constraint(equalToConstant: 28)
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
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 246 / 255, green: 248 / 255, blue: 247 / 255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = viewModel.tableHeaderView
        
        view.addSubview(parityControl)
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
    }
    
    // MARK: Action methods
    
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
