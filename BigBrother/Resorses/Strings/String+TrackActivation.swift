import Foundation

extension String.Localized.TrackActivation {

    static var navBarTitle: String {
        return .localized("TrackActivation.navBarTitle")
    }

    static var trackingActivatedTitle: String {
        return .localized("TrackActivation.trackingActivatedTitle")
    }

    static var trackingDeactivatedTitle: String {
        return .localized("TrackActivation.trackingDeactivatedTitle")
    }

    static var headerIdTitle: String {
        return .localized("TrackActivation.headerIdTitle")
    }

    static var headerDateTitle: String {
        return .localized("TrackActivation.headerDateTitle")
    }

    enum TrackingAlert {

        static var title: String {
            return .localized("TrackActivation.TrackingAlert.title")
        }

        static var message: String {
            return .localized("TrackActivation.TrackingAlert.message")
        }

        static var okButton: String {
            return .localized("TrackActivation.TrackingAlert.okButton")
        }


    }

}
