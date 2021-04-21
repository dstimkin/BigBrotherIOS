import UIKit

extension UIApplication {

    var rootServicesContainer: RootServicesContainer {
        if let delegate = delegate as? AppDelegate {
            return delegate.servicesContainer
        }

        fatalError("UIApplication.shared.delegate is not \(AppDelegate.self)")
    }

}
