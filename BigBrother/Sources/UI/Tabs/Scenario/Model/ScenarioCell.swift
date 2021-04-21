import UIKit

class ScenarioCell: UITableViewCell {

    // MARK: - Private properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .lightGray
        return label
    }()

    // MARK: - Internal methods

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(for scenario: Scenario) {
        titleLabel.text = scenario.description
        if scenario.timeFlag,
           let timeFrom = scenario.timeFrom,
           let timeTo = scenario.timeTo {
            dateLabel.text = timeFrom + " - " + timeTo
            dateLabel.isHidden = false
        }
        else {
            dateLabel.text = nil
            dateLabel.isHidden = true
        }
    }

    // MARK: - Private methods

    private func setUpLayout() {
        let safeLayout = contentView.safeAreaLayoutGuide

        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)

        titleLabel.anchor(leading: safeLayout.leadingAnchor,
                          trailing: safeLayout.trailingAnchor,
                          top: safeLayout.topAnchor,
                          paddingLeading: 20,
                          paddingTrailing: -20,
                          paddingTop: 10)

        dateLabel.anchor(leading: titleLabel.leadingAnchor,
                         trailing: titleLabel.trailingAnchor,
                         top: titleLabel.bottomAnchor,
                         bottom: safeLayout.bottomAnchor,
                         paddingBottom: -10)
    }

}
