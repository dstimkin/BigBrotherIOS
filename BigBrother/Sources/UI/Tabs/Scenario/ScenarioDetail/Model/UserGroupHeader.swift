import UIKit

final class UserGroupHeader: UITableViewHeaderFooterView {

    // MARK: - Private types

    private typealias Localized = String.Localized.Scenario.ConcreteScenario

    private enum Constants {

        static var redColor: UIColor {
            return UIColor(named: "BBRedColor")!
        }

    }

    // MARK: - Private properties

    private let userGroupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    private let relationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    // MARK: - Internal methods

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(userGroup: Scenario.UserGroup, groupNumber: Int) {
        userGroupLabel.text = Localized.userGroup + " \(groupNumber)"
        numberLabel.text = Localized.minimumParticipants + " \(userGroup.minimumNumberOfParticipants)"

        switch userGroup.relation {
        case .and:
            relationLabel.text = Localized.andRelation
        case .or:
            relationLabel.text = Localized.orRelation
        }
    }

    // MARK: - Private methods

    private func setUpLayout() {
        let safeLayout = contentView.readableContentGuide

        contentView.addSubview(userGroupLabel)
        contentView.addSubview(relationLabel)
        contentView.addSubview(numberLabel)

        userGroupLabel.anchor(leading: safeLayout.leadingAnchor,
                              trailing: safeLayout.trailingAnchor,
                              top: safeLayout.topAnchor)

        relationLabel.anchor(leading: userGroupLabel.leadingAnchor,
                             trailing: userGroupLabel.trailingAnchor,
                             top: userGroupLabel.bottomAnchor)

        numberLabel.anchor(leading: userGroupLabel.leadingAnchor,
                           trailing: userGroupLabel.trailingAnchor,
                           top: relationLabel.bottomAnchor,
                           bottom: safeLayout.bottomAnchor)
    }

}
