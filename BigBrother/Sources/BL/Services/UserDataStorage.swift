import Foundation

protocol UserDataProvider: AnyObject {

    var userID: String? { get }
    var firstName: String? { get }
    var lastName: String? { get }
    var post: String? { get }
//    var userImage: Image? { get }

    func updateData(onSucceed: (() -> Void)?)
    func resetStorage()

}

final class UserDataStorageImpl: UserDataProvider {

    // MARK: - Private properties

    private enum Constants {

        static var userIDKey: String {
            return "com.bigBrother.userIDKey"
        }

        static var firstNameKey: String {
            return "com.bigBrother.firstNameKey"
        }

        static var lastNameKey: String {
            return "com.bigBrother.lastNameKey"
        }

        static var postKey: String {
            return "com.bigBrother.post"
        }

    }

    // MARK: - Internal properties

    @Storage(key: Constants.userIDKey) var userID: String?
    @Storage(key: Constants.firstNameKey) var firstName: String?
    @Storage(key: Constants.lastNameKey) var lastName: String?
    @Storage(key: Constants.postKey) var post: String?

    // MARK: - Private properties

    private let serverHostProvider: ServerHostProvider
    private let tokenProvider: TokenProvider

    // MARK: - Init

    init(serverHostProvider: ServerHostProvider, tokenProvider: TokenProvider) {
        self.serverHostProvider = serverHostProvider
        self.tokenProvider = tokenProvider
    }

    func updateData(onSucceed: (() -> Void)?) {
        
    }

    func resetStorage() {
        userID = nil
        firstName = nil
        lastName = nil
        post = nil
    }

}
