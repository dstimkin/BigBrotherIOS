import UIKit

// MARK: - Protocols

protocol ProfileView: AnyObject {

    func applyViewModel(_ viewModel: ProfileViewModel)

}

protocol ProfileViewEventHandler: AnyObject {

    func onExitButtonTap()

}

struct ProfileViewModel {

    let profileImage: UIImage?
    let name: String
    let post: String

    init(profileImage: UIImage?, name: String, post: String) {
        self.profileImage = profileImage
        self.name = name
        self.post = post
    }

}

// MARK: - Implementation

final class ProfileViewImpl: UIViewController, ProfileView {

    // MARK: - Private types

    private enum Constants {

        static var profileImageMock: UIImage? {
            return UIImage(named: "person_mock")
        }

        static var profileImageSize: CGFloat {
            return 200.0
        }

        static var buttonColor: UIColor {
            return UIColor(named: "BBRedColor")!
        }

        static var backgroundColor: UIColor {
            return UIColor(named: "BBBackgroundColor")!
        }

    }

    // MARK: - Internal properties

    weak var eventHandler: ProfileViewEventHandler?

    // MARK: - Private properties

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.profileImageMock
        imageView.layer.cornerRadius = Constants.profileImageSize / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 35)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 23)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(String.Localized.Profile.exitButtonLabel, for: .normal)
        button.backgroundColor = Constants.buttonColor
        button.addTarget(self,
                         action: #selector(onExitButtonTap),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - Internal methods

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.backgroundColor
        setUpLayout()
    }

    func applyViewModel(_ viewModel: ProfileViewModel) {
        profileImageView.image = viewModel.profileImage ?? Constants.profileImageMock
        nameLabel.text = viewModel.name
        postLabel.text = viewModel.post
    }

    // MARK: - Private Methods

    private func setUpLayout() {
        let safeLayout = view.safeAreaLayoutGuide

        let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        view.addSubview(containerView)

        containerView.centerVertically(to: safeLayout.centerYAnchor)
        containerView.anchor(leading: safeLayout.leadingAnchor,
                             trailing: safeLayout.trailingAnchor)

        containerView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(postLabel)
        containerView.addSubview(exitButton)

        profileImageView.centerHorizontally()
        profileImageView.anchor(top: containerView.topAnchor,
                                width: Constants.profileImageSize,
                                height: Constants.profileImageSize)

        nameLabel.anchor(leading: containerView.leadingAnchor,
                         trailing: containerView.trailingAnchor,
                         top: profileImageView.bottomAnchor,
                         paddingLeading: 20,
                         paddingTrailing: -20,
                         paddingTop: 20)

        postLabel.anchor(leading: nameLabel.leadingAnchor,
                         trailing: nameLabel.trailingAnchor,
                         top: nameLabel.bottomAnchor,
                         paddingTop: 6)

        exitButton.anchor(leading: nameLabel.leadingAnchor,
                          trailing: nameLabel.trailingAnchor,
                          top: postLabel.bottomAnchor,
                          bottom: containerView.bottomAnchor,
                          paddingTop: 30,
                          height: 50)
    }

    @objc
    private func onExitButtonTap(_ sender: UIButton) {
        typealias Localized = String.Localized.Profile.ConfirmationAlert
        let onConfirmButtonTap: ((UIAlertAction) -> ()) = { _ in
            self.eventHandler?.onExitButtonTap()
        }

        let alert = UIAlertController(title: Localized.title,
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localized.rejectButtonTitle,
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: Localized.confirmButtonTitle,
                                      style: .destructive,
                                      handler: onConfirmButtonTap))
        present(alert, animated: true, completion: nil)
    }

}
