import Foundation

extension String.Localized.Profile {

    static var exitButtonLabel: String {
        return .localized("Profile.exitButtonLabel")
    }

    enum ConfirmationAlert {

        static var title: String {
            return .localized("Profile.ConfirmationAlert.title")
        }

        static var confirmButtonTitle: String {
            return .localized("Profile.ConfirmationAlert.confirmButtonTitle")
        }

        static var rejectButtonTitle: String {
            return .localized("Profile.ConfirmationAlert.rejectButtonTitle")
        }

    }

}
