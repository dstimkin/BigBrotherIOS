import UIKit

// MARK: - Protocols

protocol TrackActivationView: AnyObject {

    func updateContacts(_ contacts: [Contact])
    func activateTracking(_ activate: Bool)
    func showTrackingErrorAlert()

}

protocol TrackActivationViewEventHandler: AnyObject {

    func onTrackActivated(_ activated: Bool)

}

// MARK: - Implementation

final class TrackActivationViewImpl: UIViewController, TrackActivationView {

    // MARK: - Private types

    private typealias Localized = String.Localized.TrackActivation
    private enum Constants {

        static var contactCellIdentifier: String {
            return "ContactCell"
        }

        static var contactHeaderIdentifier: String {
            return "ContactHeader"
        }

        static var trackActivatedBackgroundColor: UIColor {
            return UIColor(named: "BBGreenColor")!
        }

        static var backgroundColor: UIColor {
            return UIColor(named: "BBBackgroundColor")!
        }

        static var trackDeactivatedBackgroundColor: UIColor {
            return UIColor(named: "BBRedColor")!
        }

    }

    // MARK: - Internal properties

    weak var eventHandler: TrackActivationViewEventHandler?

    // MARK: - Private properties

    private var trackActivationToggle: RAMPaperSwitch!
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let activationButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.trackDeactivatedBackgroundColor
        return view
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.register(ContactCell.self,
                           forCellReuseIdentifier: Constants.contactCellIdentifier)
        tableView.register(ContactTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: Constants.contactHeaderIdentifier)
        return tableView
    }()

    private var isTrackingActivated = false
    private var lastContacts: [Contact] = []

    // MARK: - Internal Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func updateContacts(_ contacts: [Contact]) {
        lastContacts = contacts
        tableView.reloadData()
    }

    func activateTracking(_ activate: Bool) {
        isTrackingActivated = activate
        statusLabel.text = activate
            ? Localized.trackingActivatedTitle
            : Localized.trackingDeactivatedTitle

        UIView.animate(withDuration: 0.35) {
            self.tableView.alpha = activate ? 1.0 : 0.5
        }
    }

    func showTrackingErrorAlert() {
        let alert = UIAlertController(title: Localized.TrackingAlert.title,
                                      message: Localized.TrackingAlert.message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localized.TrackingAlert.okButton,
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Private methods

    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = Constants.backgroundColor
        navigationItem.title = Localized.navBarTitle

        configureTrackActivationToggle()
        setUpLayout()
    }

    private func configureTrackActivationToggle() {
        trackActivationToggle = RAMPaperSwitch(view: activationButtonView, color: Constants.trackActivatedBackgroundColor)
        trackActivationToggle.translatesAutoresizingMaskIntoConstraints = false
        trackActivationToggle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        trackActivationToggle.isOn = isTrackingActivated
        trackActivationToggle.addTarget(self,
                                        action: #selector(onTrackActivationToggleTap),
                                        for: .touchUpInside)
    }

    private func setUpLayout() {
        let safeLayout = view.safeAreaLayoutGuide

        view.addSubview(activationButtonView)
        activationButtonView.anchor(leading: safeLayout.leadingAnchor,
                                    trailing: safeLayout.trailingAnchor,
                                    top: safeLayout.topAnchor,
                                    height: 80)

        activationButtonView.addSubview(trackActivationToggle)
        activationButtonView.addSubview(statusLabel)

        trackActivationToggle.centerVertically()
        trackActivationToggle.anchor(trailing: activationButtonView.trailingAnchor,
                                     paddingTrailing: -20)

        statusLabel.centerVertically()
        statusLabel.anchor(leading: activationButtonView.leadingAnchor,
                           trailing: trackActivationToggle.leadingAnchor,
                           paddingLeading: 10,
                           paddingTrailing: -20)

        view.addSubview(tableView)
        tableView.anchor(leading: safeLayout.leadingAnchor,
                         trailing: safeLayout.trailingAnchor,
                         top: activationButtonView.bottomAnchor,
                         bottom: safeLayout.bottomAnchor)
    }

    @objc
    private func onTrackActivationToggleTap(_ sender: UISwitch) {
        eventHandler?.onTrackActivated(sender.isOn)
        activateTracking(sender.isOn)
    }

}

// MARK: - Protocol UITableViewDataSource

extension TrackActivationViewImpl: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return lastContacts.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = Constants.contactCellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath) as! ContactCell
        cell.configureCell(contact: lastContacts[indexPath.row])

        return cell
    }

}

// MARK: - Protocol UITableViewDelegate

extension TrackActivationViewImpl: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.contactHeaderIdentifier) as! ContactTableViewHeader
        header.configure(leftTitle: Localized.headerIdTitle,
                         rightTitle: Localized.headerDateTitle)

        return header
    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
