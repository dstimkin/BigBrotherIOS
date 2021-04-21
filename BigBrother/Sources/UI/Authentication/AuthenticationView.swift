import UIKit

// MARK: - Protocols

protocol AuthenticationView: AnyObject {

    func showAlert(title: String, message: String, buttonTitle: String)

}

protocol AuthenticationViewEventHandler: AnyObject {

    func onSignInButtonTap(server: String?, login: String?, password: String?)

}


// MARK: - Implementation

final class AuthenticationViewImpl: UIViewController, AuthenticationView {

    // MARK: - Private types

    private typealias Localized = String.Localized.Authentication

    private enum Constants {

        static var logoImageName: String {
            return "logo_circle"
        }

        static var logoImageSize: CGFloat {
            return 150.0
        }

        static var labelTextSize: CGFloat {
            return 20.0
        }

        static var textFieldsTextSize: CGFloat {
            return 20.0
        }

        static var textFieldsHeight: CGFloat {
            return 40.0
        }

        static var buttonColor: UIColor {
            return UIColor(named: "BBRedColor")!
        }

        static var backgroundColor: UIColor {
            return UIColor(named: "BBBackgroundColor")!
        }

    }

    // MARK: - Internal properties

    weak var eventHandler: AuthenticationViewEventHandler?

    // MARK: - Private properties

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Constants.logoImageName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.logoImageSize / 2

        return imageView
    }()

    private let serverLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Constants.labelTextSize)
        label.text = Localized.serverLabel

        return label
    }()

    private let serverField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = UITextField.BorderStyle.bezel
        field.autocapitalizationType = .none
        field.keyboardType = .asciiCapable
        field.autocorrectionType = .no
        field.font = .systemFont(ofSize: 20)

        return field
    }()

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Constants.labelTextSize)
        label.text = Localized.loginLabel

        return label
    }()

    private let loginField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = UITextField.BorderStyle.bezel
        field.autocapitalizationType = .none
        field.keyboardType = .asciiCapable
        field.autocorrectionType = .no
        field.font = .systemFont(ofSize: 20)

        return field
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Constants.textFieldsTextSize)
        label.text = Localized.passwordLabel

        return label
    }()

    private let passwordField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = UITextField.BorderStyle.bezel
        field.isSecureTextEntry = true
        field.keyboardType = .asciiCapable
        field.autocorrectionType = .no
        field.font = .systemFont(ofSize: Constants.textFieldsTextSize)

        return field
    }()

    private let showPasswordButton: UIButton? = {
        if let image = UIImage(named: "eye") {
            let showPasswordButton = UIButton()
            showPasswordButton.setImage(image, for: .normal)

            showPasswordButton.imageEdgeInsets = .init(top: 0,
                                                       left: -10,
                                                       bottom: 0,
                                                       right: 10)
            showPasswordButton.addTarget(self,
                                         action: #selector(onShowPasswordButtonTap),
                                         for: .touchUpInside)
            return showPasswordButton
        }

        return nil
    }()

    private let signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Localized.signInButton, for: .normal)
        button.backgroundColor = Constants.buttonColor
        button.addTarget(self,
                         action: #selector(onSignInButtonTap),
                         for: .touchUpInside)

        return button
    }()

    // MARK: - Internal Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        serverField.delegate = self
        loginField.delegate = self
        passwordField.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

        configure()
        setUpLayout()
        applyColorScheme()
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle,
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
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

        containerView.addSubview(serverLabel)
        containerView.addSubview(serverField)
        containerView.addSubview(logoImageView)
        containerView.addSubview(loginLabel)
        containerView.addSubview(loginField)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(passwordField)
        containerView.addSubview(signInButton)

        logoImageView.centerHorizontally(to: containerView.centerXAnchor)
        logoImageView.anchor(top: containerView.topAnchor,
                             width: Constants.logoImageSize,
                             height: Constants.logoImageSize)

        serverLabel.anchor(leading: containerView.leadingAnchor,
                           top: logoImageView.bottomAnchor,
                           paddingLeading: 20,
                           paddingTop: 15)

        serverField.anchor(leading: serverLabel.leadingAnchor,
                          trailing: containerView.trailingAnchor,
                          top: serverLabel.bottomAnchor,
                          paddingTrailing: -20,
                          paddingTop: 6,
                          height: Constants.textFieldsHeight)

        loginLabel.anchor(leading: serverLabel.leadingAnchor,
                          top: serverField.bottomAnchor,
                          paddingTop: 20)

        loginField.anchor(leading: serverLabel.leadingAnchor,
                          trailing: serverField.trailingAnchor,
                          top: loginLabel.bottomAnchor,
                          paddingTop: 6,
                          height: Constants.textFieldsHeight)

        passwordLabel.anchor(leading: serverLabel.leadingAnchor,
                             top: loginField.bottomAnchor,
                             paddingTop: 20)

        passwordField.anchor(leading: serverLabel.leadingAnchor,
                             trailing: serverField.trailingAnchor,
                             top: passwordLabel.bottomAnchor,
                             paddingTop: 6,
                             height: Constants.textFieldsHeight)

        signInButton.anchor(leading: serverLabel.leadingAnchor,
                            trailing: serverField.trailingAnchor,
                            top: passwordField.bottomAnchor,
                            bottom: containerView.bottomAnchor,
                            paddingTop: 40,
                            height: 50)
    }

    private func configure() {
        if let showPasswordButton = showPasswordButton {
            passwordField.rightView = showPasswordButton
            passwordField.rightViewMode = .always
        }
        else {
            passwordField.rightViewMode = .never
        }
    }

    private func applyColorScheme() {
        if #available(iOS 13.0, *) {
            showPasswordButton?.tintColor = .label
        } else {
            showPasswordButton?.tintColor = .black
        }
        view.backgroundColor = Constants.backgroundColor
    }

    @objc
    private func onShowPasswordButtonTap(_ sender: UIButton) {
        if passwordField.isSecureTextEntry {
            passwordField.isSecureTextEntry = false
            if let image = UIImage(named: "eye.slash") {
                sender.setImage(image,
                                for: .normal)
            }
        }
        else {
            passwordField.isSecureTextEntry = true
            if let image = UIImage(named: "eye") {
                sender.setImage(image,
                                for: .normal)
            }
        }
    }


    @objc
    private func onSignInButtonTap() {
        view.endEditing(true)
        eventHandler?.onSignInButtonTap(server: serverField.text,
                                        login: loginField.text,
                                        password: passwordField.text)
    }

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 100
            }
        }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}

// MARK: - Protocol UITextFieldDelegate

extension AuthenticationViewImpl: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === serverField {
            loginField.becomeFirstResponder()
        }
        else if textField === loginField {
            passwordField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }

        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
