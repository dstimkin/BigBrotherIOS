import UIKit

// MARK: - Protocol

public protocol ViewableRouter: Router {

    var viewController: UIViewController { get }

}
