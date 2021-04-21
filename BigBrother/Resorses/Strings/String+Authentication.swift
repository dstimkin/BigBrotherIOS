import Foundation

extension String.Localized.Authentication {

    static var serverLabel: String {
        return .localized("Authentication.serverLabel")
    }

    static var loginLabel: String {
        return .localized("Authentication.loginLabel")
    }

    static var passwordLabel: String {
        return .localized("Authentication.passwordLabel")
    }

    static var signInButton: String {
        return .localized("Authentication.signInButton")
    }

    enum InvalidCredentialsErrorAlert {

        static var title: String {
            return .localized("Authentication.InvalidCredentialsErrorAlert.title")
        }

        static var message: String {
            return .localized("Authentication.InvalidCredentialsErrorAlert.message")
        }

        static var okButton: String {
            return .localized("Authentication.InvalidCredentialsErrorAlert.okButton")
        }
        
    }

    enum InvalidHostErrorAlert {

        static var title: String {
            return .localized("Authentication.InvalidHostErrorAlert.title")
        }

        static var message: String {
            return .localized("Authentication.InvalidHostErrorAlert.message")
        }

        static var okButton: String {
            return .localized("Authentication.InvalidHostErrorAlert.okButton")
        }

    }

    enum InternalErrorAlert {

        static var title: String {
            return .localized("Authentication.InternalErrorAlert.title")
        }

        static var message: String {
            return .localized("Authentication.InternalErrorAlert.message")
        }

        static var okButton: String {
            return .localized("Authentication.InternalErrorAlert.okButton")
        }

    }

    enum EmptyFieldAlert {

        static var title: String {
            return .localized("Authentication.EmptyFieldAlert.title")
        }

        static var message: String {
            return .localized("Authentication.EmptyFieldAlert.message")
        }

        static var okButton: String {
            return .localized("Authentication.EmptyFieldAlert.okButton")
        }

    }

}
