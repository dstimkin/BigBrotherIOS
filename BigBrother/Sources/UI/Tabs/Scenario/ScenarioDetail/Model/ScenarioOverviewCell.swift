import UIKit

final class ScenarioOverviewCell: UITableViewCell {

    // MARK: - Private types

    private typealias Localized = String.Localized.Scenario.ConcreteScenario

    private enum Constants {

        static var redColor: UIColor {
            return UIColor(named: "BBRedColor")!
        }

    }

    // MARK: - Private properties

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .gray
        return label
    }()

    private let periodAttribute: ScenarioAttributeView = {
        let attribute = ScenarioAttributeView(title: .empty,
                                              backgroundColor: .systemBlue,
                                              cornerStyle: .custom(value: 5))
        attribute.translatesAutoresizingMaskIntoConstraints = false
        return attribute
    }()

    private let daysOfWeekCollectionView: DaysOfWeekCollectionView = {
        let collectionView = DaysOfWeekCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = nil
        return collectionView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal methods

    func configure(with scenario: Scenario) {
        if scenario.timeFlag,
           let timeFrom = scenario.timeFrom,
           let timeTo = scenario.timeTo {
            dateLabel.text = timeFrom + " - " + timeTo
            dateLabel.isHidden = false
        }
        else {
            dateLabel.text = ""
            dateLabel.isHidden = true
        }

        if scenario.periodFlag, let period = scenario.period {
            periodAttribute.isHidden = false
            periodAttribute.titleLabel.text = Localized.period1 + " \(period) " + Localized.period2
        }
        else {
            periodAttribute.isHidden = true
            periodAttribute.titleLabel.text = nil
        }

        if scenario.daysOfWeek.count == 7 {
            daysOfWeekCollectionView.configure(for: scenario.daysOfWeek)
            daysOfWeekCollectionView.isHidden = false
        }
        else {
            daysOfWeekCollectionView.configure(for: [])
            daysOfWeekCollectionView.isHidden = true
        }

        descriptionLabel.text = scenario.description
    }

    // MARK: - Private methods

    private func setUpLayout() {
        let safeLayout = contentView.safeAreaLayoutGuide

        contentView.addSubview(dateLabel)
        contentView.addSubview(periodAttribute)
        contentView.addSubview(daysOfWeekCollectionView)
        contentView.addSubview(descriptionLabel)

        dateLabel.anchor(leading: safeLayout.leadingAnchor,
                         trailing: safeLayout.trailingAnchor,
                         top: safeLayout.topAnchor,
                         paddingLeading: 15,
                         paddingTrailing: -15,
                         paddingTop: 15)

        periodAttribute.anchor(leading: dateLabel.leadingAnchor,
                               top: dateLabel.bottomAnchor,
                               paddingTop: 5)

        daysOfWeekCollectionView.anchor(leading: contentView.leadingAnchor,
                                        trailing: contentView.trailingAnchor,
                                        top: periodAttribute.bottomAnchor,
                                        paddingTop: 5,
                                        height: 40)

        descriptionLabel.anchor(leading: dateLabel.leadingAnchor,
                                trailing: dateLabel.trailingAnchor,
                                top: daysOfWeekCollectionView.bottomAnchor,
                                bottom: safeLayout.bottomAnchor,
                                paddingTop: 10,
                                paddingBottom: -15)
    }

}
