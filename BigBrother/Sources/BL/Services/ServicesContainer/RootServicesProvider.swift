import Foundation

protocol RootServicesContainer: AnyObject {

    var authenticationService: AuthenticationService { get }
    var contactsStorage: ContactsStorage { get }
    var serverHostStorage: ServerHostStorage { get }
    var userDataProvider: UserDataProvider { get }

}

class RootServicesProvider {

    // MARK: - Internal properties

    let rootContainer: RootServicesContainer

    // MARK: - Init

    init(rootContainer: RootServicesContainer) {
        self.rootContainer = rootContainer
    }

}
