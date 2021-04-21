import Foundation
import UIKit

// MARK: - Protocol

protocol AuthenticationRouter: ViewableRouter {

}

// MARK: - Implementation

final class AuthenticationRouterImpl: BaseRouter, AuthenticationRouter {

    var viewController: UIViewController

    init(viewController: UIViewController, interactor: Interactor) {
        self.viewController = viewController
        super.init(interactor: interactor)
    }

}
