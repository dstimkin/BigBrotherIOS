import Foundation

// MARK: - Protocols

protocol AuthenticationInteractor: AnyObject {

    func authenticate(server: String, login: String, password: String)
    
}

protocol AuthenticationListener: AnyObject {

    func onSuccessAuthentication()

}

// MARK: - Implementation

final class AuthenticationInteractorImpl: BaseInteractor, AuthenticationInteractor {

    // MARK: - Internal properties

    weak var router: AuthenticationRouter?

    // MARK: - Private properties

    private var presenter: AuthenticationPresenter
    private weak var listener: AuthenticationListener?

    private var authenticationService: AuthenticationService
    private let serverHostStorage: ServerHostStorage

    // MARK: - Init

    init(presenter: AuthenticationPresenter,
         authenticationService: AuthenticationService,
         serverHostStorage: ServerHostStorage,
         listener: AuthenticationListener? = nil) {

        self.presenter = presenter
        self.authenticationService = authenticationService
        self.serverHostStorage = serverHostStorage
        self.listener = listener
    }

    // MARK: - Internal methods

    func authenticate(server: String, login: String, password: String) {
        serverHostStorage.serverHost = server

        authenticationService.authenticate(login: login,
                                           password: password,
                                           completion: authenticationHandler)

        listener?.onSuccessAuthentication()
    }

    func authenticationHandler(for authenticationResult: AuthenticationResult) {
//        switch authenticationResult {
//        case .success:
//            listener?.onSuccessAuthentication()
//
//        case .error(let error):
//            presenter.presentAlert(for: error)
//        }
    }

}
