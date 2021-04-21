import Foundation

// MARK: - Protocol

protocol AuthenticationPresenter: AnyObject {

    func presentAlert(for error: AuthenticationResult.ErrorType)

}

// MARK: - Implementation

final class AuthenticationPresenterImpl: AuthenticationPresenter {

    // MARK: - Private types

    private typealias Localized = String.Localized.Authentication

    // MARK: - Internal types

    weak var view: AuthenticationView?
    weak var interactor: AuthenticationInteractor?

    // MARK: - Internal methods

    func presentAlert(for error: AuthenticationResult.ErrorType) {
        switch error {
        case .invalidCredentials:
            view?.showAlert(title: Localized.InvalidCredentialsErrorAlert.title,
                            message: Localized.InvalidCredentialsErrorAlert.message,
                            buttonTitle: Localized.InvalidCredentialsErrorAlert.okButton)

        case .invalidHost:
            view?.showAlert(title: Localized.InvalidHostErrorAlert.title,
                            message: Localized.InvalidHostErrorAlert.message,
                            buttonTitle: Localized.InvalidHostErrorAlert.okButton)

        case .serverError:
            view?.showAlert(title: Localized.InternalErrorAlert.title,
                            message: Localized.InternalErrorAlert.message,
                            buttonTitle: Localized.InternalErrorAlert.okButton)
        }
    }

    // MARK: - Private methods

    private func validateIpOrDomain(for string: String) -> Bool {
        let ipAddress =  "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
        let domain = "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$"

        let stringIsIP = string.range(of: ipAddress,
                                      options: .regularExpression,
                                      range: nil,
                                      locale: nil) != nil

        let stringIsDomain = string.range(of: domain,
                                          options: .regularExpression,
                                          range: nil,
                                          locale: nil) != nil
        return stringIsIP || stringIsDomain
    }

}

// MARK: - Protocol AuthenticationViewEventHandler

extension AuthenticationPresenterImpl: AuthenticationViewEventHandler {

    func onSignInButtonTap(server: String?, login: String?, password: String?) {
        guard
            let server = server,
            let login = login,
            let password = password,
            !server.isEmpty,
            !login.isEmpty,
            !password.isEmpty
        else {
            view?.showAlert(title: Localized.EmptyFieldAlert.title,
                            message: Localized.EmptyFieldAlert.message,
                            buttonTitle: Localized.EmptyFieldAlert.okButton)
            return
        }

        guard validateIpOrDomain(for: server) else {
            presentAlert(for: .invalidHost)
            return
        }

        interactor?.authenticate(server: server, login: login, password: password)
    }

}
