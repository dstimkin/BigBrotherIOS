import UIKit

final class ContactTableViewHeader: UITableViewHeaderFooterView {

    // MARK: - Private properties

    private let leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
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

    func configure(leftTitle: String, rightTitle: String) {
        leftLabel.text = leftTitle
        rightLabel.text = rightTitle
    }

    // MARK: - Private methods

    private func setUpLayout() {
        let safeLayout = contentView.safeAreaLayoutGuide

        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)

        leftLabel.centerVertically()
        leftLabel.anchor(leading: safeLayout.leadingAnchor,
                         paddingLeading: 10)

        rightLabel.centerVertically()
        rightLabel.anchor(trailing: safeLayout.trailingAnchor,
                          paddingTrailing: -10)
    }

}
