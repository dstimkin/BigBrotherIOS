import Foundation
import UIKit

// MARK: - Protocols

protocol ScenarioDetailView: AnyObject {

    func configureForScenario(_ scenario: Scenario)

}

protocol ScenarioDetailViewEventHandler: AnyObject {

    func onCompleteButtonTap()

}

// MARK: - Implementation

final class ScenarioDetailViewImpl: UIViewController, ScenarioDetailView {

    // MARK: - Private types

    private enum Constants {

        static var backgroundColor: UIColor {
            return UIColor(named: "BBBackgroundColor")!
        }

        static var scenarioOverviewCellId: String {
            return "ScenarioOverviewCell"
        }

        static var groupMemberCellId: String {
            return "GroupMemberCell"
        }

        static var userGroupHeaderId: String {
            return "UserGroupHeader"
        }
        
    }

    // MARK: - Internal properties

    weak var eventHandler: ScenarioDetailViewEventHandler?

    // MARK: - Private properties

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.register(ScenarioOverviewCell.self,
                           forCellReuseIdentifier: Constants.scenarioOverviewCellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.groupMemberCellId)
        tableView.register(UserGroupHeader.self,
                           forHeaderFooterViewReuseIdentifier: Constants.userGroupHeaderId)
        return tableView
    }()

    private var scenario: Scenario = .empty

    // MARK: - Internal methods

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.backgroundColor
        navigationItem.largeTitleDisplayMode = .never
        tableView.dataSource = self
        tableView.delegate = self
        setUpLayout()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isMovingFromParent {
            eventHandler?.onCompleteButtonTap()
        }
    }

    func configureForScenario(_ scenario: Scenario) {
        self.scenario = scenario
        tableView.reloadData()
    }

    // MARK: - Private methods

    private func setUpLayout() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }

}

// MARK: - Protocol UITableViewDataSource

extension ScenarioDetailViewImpl: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + scenario.userGroups.count
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : scenario.userGroups[section - 1].items.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.scenarioOverviewCellId,
                                                     for: indexPath) as! ScenarioOverviewCell
            cell.configure(with: scenario)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.groupMemberCellId) ??
                UITableViewCell(style: .default, reuseIdentifier: Constants.groupMemberCellId)
            cell.textLabel?.font = .systemFont(ofSize: 20)
            cell.textLabel?.text = scenario.userGroups[indexPath.section - 1].items[indexPath.row]
            return cell
        }
    }

}

// MARK: - Protocol UITableViewDelegate

extension ScenarioDetailViewImpl: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {

        if section == 0 {
            return nil
        }

        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.userGroupHeaderId) as! UserGroupHeader
        header.configure(userGroup: scenario.userGroups[section - 1], groupNumber: section)

        return header
    }

}
