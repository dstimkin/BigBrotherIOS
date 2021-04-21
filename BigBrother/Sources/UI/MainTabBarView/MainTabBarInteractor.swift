import Foundation

// MARK: - Protocol

protocol MainTabBarInteractor: AnyObject {

}

// MARK: - Implementation

final class MainTabBarInteractorImpl: BaseInteractor, MainTabBarInteractor {

    // MARK: - Internal properties

    weak var router: MainTabBarRouter?
    weak var mainTabBarView: MainTabBarView?

    // MARK: - Private properties

    private let authenticationService: AuthenticationService
    private let userDataProvider: UserDataProvider
    private let contactsStorage: ContactsStorage
    private let notificationCenter: NotificationCenter

    // MARK: - Init & deinit

    init(authenticationService: AuthenticationService,
         userDataProvider: UserDataProvider,
         contactsStorage: ContactsStorage,
         notificationCenter: NotificationCenter = NotificationCenter.default) {

        self.authenticationService = authenticationService
        self.userDataProvider = userDataProvider
        self.contactsStorage = contactsStorage
        self.notificationCenter = notificationCenter

        super.init()
        configureObservers()
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    // MARK: - Internal methods

    override func start() {
        super.start()

        if !authenticationService.isTokenValid {
            attachTabs()
        }
        else {
            router?.attachAuthenticationScreen(animated: false, listener: self)
        }
    }

    override func stop() {
        router?.detachTabs()
        super.stop()
    }

    // MARK: - Private methods

    private func configureObservers() {
        let notificationName = Notification.Name(rawValue: String.ObserverNotification.userSignOut)
        notificationCenter.addObserver(self,
                                       selector: #selector(signOut),
                                       name: notificationName,
                                       object: nil)
    }

    private func attachTabs() {
        router?.attachTrackActivationScreen()
        router?.attachScenarioScreen()
        router?.attachProfileScreen(listener: self)
    }

    @objc
    private func signOut() {
        authenticationService.signOut()
        userDataProvider.resetStorage()
        contactsStorage.resetStorage()

        router?.detachTabs()
        router?.attachAuthenticationScreen(animated: true, listener: self)
    }
    
}

// MARK: - Protocol AuthenticationListener

extension MainTabBarInteractorImpl: AuthenticationListener {

    func onSuccessAuthentication() {
        attachTabs()
        router?.detachAuthenticationScreen()
    }

}

// MARK: - Protocol ProfileListener

extension MainTabBarInteractorImpl: ProfileListener {

    func onAccountExitProceed() {
        signOut()
    }

}
