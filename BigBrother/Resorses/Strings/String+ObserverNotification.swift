import Foundation

extension String {

    enum ObserverNotification {}

}

extension String.ObserverNotification {

    static var userSignOut: String {
        return "com.bigbrother.user_did_sign_out"
    }

}
