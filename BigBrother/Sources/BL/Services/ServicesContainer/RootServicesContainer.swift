import Foundation

final class RootServicesContainerImpl: RootServicesContainer {

    // MARK: - Internal properties

    var serverHostStorage: ServerHostStorage = ServerHostStorageImpl()
    var contactsStorage: ContactsStorage = ContactsStorageImpl()
    var authenticationService: AuthenticationService
    var userDataProvider: UserDataProvider

    // MARK: - Init

    init() {
        authenticationService = AuthenticationServiceImpl(serverHostProvider: serverHostStorage)

        userDataProvider = UserDataStorageImpl(serverHostProvider: serverHostStorage,
                                               tokenProvider: authenticationService)
    }

}
