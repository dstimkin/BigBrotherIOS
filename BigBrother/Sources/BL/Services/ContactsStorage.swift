import Foundation

// MARK: - Protocol

protocol ContactsStorage: AnyObject {

    var lastContacts: [Contact]? { get set }
    var unsentContacts: [Contact]? { get set }
    var toggleState: Bool? { get set }

    func resetStorage()

}

// MARK: - Implementation

final class ContactsStorageImpl: ContactsStorage {

    // MARK: - Private types

    private enum Constants {

        static var lastContactsKey: String {
            return "com.bigBrother.lastContactsKey"
        }

        static var unsentContactsKey: String {
            return "com.bigBrother.unsentContactsKey"
        }

        static var toggleStateKey: String {
            return "com.bigBrother.toggleStateKey"
        }

    }

    // MARK: - Internal properties

    @CustomObjectStorage(key: Constants.lastContactsKey) internal var lastContacts: [Contact]?
    @CustomObjectStorage(key: Constants.unsentContactsKey) internal var unsentContacts: [Contact]?
    @Storage(key: Constants.toggleStateKey) internal var toggleState: Bool?

    // MARK: - Internal methods

    func resetStorage() {
        lastContacts = nil
        unsentContacts = nil
        toggleState = nil
    }

}
