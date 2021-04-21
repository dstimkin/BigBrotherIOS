import Foundation

extension String {

    public enum Localized {}

}

extension String.Localized {

    enum Tabs {}
    enum Authentication {}
    enum TrackActivation {}
    enum Scenario {}
    enum Profile {}
    enum Notifications {}

}

extension String {

    static func localized(_ key: String) -> String {
        return NSLocalizedString(key, bundle: .main, comment: .empty)
    }

}
