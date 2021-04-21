import Foundation

// MARK: - Protocols

protocol ServerHostProvider: AnyObject {

    var serverHost: String? { get }

}

protocol ServerHostStorage: ServerHostProvider {

    var serverHost: String? { get set }

}

// MARK: - Implementation

final class ServerHostStorageImpl: ServerHostStorage {

    // MARK: - Private properties

    private enum Constants {

        static var serverHostKey: String {
            return "com.bigBrother.serverHostKey"
        }

    }

    // MARK: - Internal properties

    @Storage(key: Constants.serverHostKey) var serverHost: String?

}

