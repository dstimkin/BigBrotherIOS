import UIKit

final class ScenarioAttributeView: UIView {

    enum CornerStyle {
        case rounded
        case custom(value: CGFloat)
    }

    // MARK: - Internal properties

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()

    var cornerStyle: CornerStyle = .rounded

    // MARK: - Init

    init() {
        super.init(frame: .zero)
    }

    init(title: String, backgroundColor: UIColor, cornerStyle: CornerStyle) {
        super.init(frame: .zero)

        setUpLayout()
        titleLabel.text = title
        self.backgroundColor = backgroundColor
        self.cornerStyle = cornerStyle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal methods

    override func layoutSubviews() {
        super.layoutSubviews()

        switch cornerStyle {
        case .rounded:
            layer.cornerRadius = frame.midY

        case .custom(let value):
            layer.cornerRadius = value
        }
    }

    // MARK: - Private methods

    private func setUpLayout() {
        addSubview(titleLabel)
        titleLabel.anchor(leading: leadingAnchor,
                          trailing: trailingAnchor,
                          top: topAnchor,
                          bottom: bottomAnchor,
                          paddingLeading: 12,
                          paddingTrailing: -12,
                          paddingTop: 3,
                          paddingBottom: -3)
    }

}
