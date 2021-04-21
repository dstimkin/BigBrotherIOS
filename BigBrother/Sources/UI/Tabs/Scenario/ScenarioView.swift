import UIKit

// MARK: - Protocols

protocol ScenarioView: AnyObject {

    func updateData(_ scenarios: [Scenario])

}

protocol ScenarioViewEventHandler: AnyObject {

    func onSelectRow(with scenario: Scenario)

}

// MARK: - Implementation

final class ScenarioViewImpl: UIViewController, ScenarioView {

    // MARK: - Private types

    private typealias Localized = String.Localized.Scenario

    private enum Constants {

        static var scenarioCellIdentifier: String {
            return "ScenarioCell"
        }

        static var backgroundColor: UIColor {
            return UIColor(named: "BBBackgroundColor")!
        }

    }

    // MARK: - Internal properties

    weak var eventHandler: ScenarioViewEventHandler?

    // MARK: - Private properties

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ScenarioCell.self,
                           forCellReuseIdentifier: Constants.scenarioCellIdentifier)

        return tableView
    }()

    private var scenarios = [Scenario]()

    // MARK: - Internal methods

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Localized.navBarTitle
        tableView.dataSource = self
        tableView.delegate = self
        setUpLayout()
    }

    func updateData(_ scenarios: [Scenario]) {
        self.scenarios = scenarios
        tableView.reloadData()
    }

    // MARK: - Private methods

    private func setUpLayout() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }

}

// MARK: - Protocol UITableViewDataSource

extension ScenarioViewImpl: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scenarios.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.scenarioCellIdentifier, for: indexPath) as! ScenarioCell
        cell.accessoryType = .disclosureIndicator
        cell.configure(for: scenarios[indexPath.row])

        return cell
    }

}

// MARK: - Protocol UITableViewDelegate

extension ScenarioViewImpl: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        eventHandler?.onSelectRow(with: scenarios[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


