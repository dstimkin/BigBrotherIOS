import UIKit

final class DaysOfWeekCollectionViewCell: UICollectionViewCell {

    // MARK: - Internal properties

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal methods

    func configure(title: String, backgroundColor: UIColor) {
        titleLabel.text = title
        self.backgroundColor = backgroundColor
    }

    // MARK: - Private methods

    private func setUpLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.centerVertically()
        titleLabel.centerHorizontally()
    }

}
