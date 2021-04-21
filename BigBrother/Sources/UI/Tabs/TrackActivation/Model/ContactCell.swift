import UIKit

final class ContactCell: UITableViewCell {

    // MARK: - Private properties

    private let secondContacteeIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()

    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, HH:mm:ss"
        return dateFormatter
    }()

    // MARK: - Internal methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(contact: Contact) {
        secondContacteeIdLabel.text = String(contact.secondContacteeId)
        dateLabel.text = dateFormatter.string(from: contact.dateOfContact)
    }

    // MARK: - Private methods

    private func setUpLayout() {
        let safeLayout = contentView.safeAreaLayoutGuide

        contentView.addSubview(secondContacteeIdLabel)
        contentView.addSubview(dateLabel)

        secondContacteeIdLabel.centerVertically()
        secondContacteeIdLabel.anchor(leading: safeLayout.leadingAnchor,
                                      paddingLeading: 10)

        dateLabel.centerVertically()
        dateLabel.anchor(trailing: safeLayout.trailingAnchor,
                         paddingTrailing: -10)
    }

}
