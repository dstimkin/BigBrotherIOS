import UIKit

// MARK: - Protocol

protocol ProfileRouter: ViewableRouter {

}

// MARK: - Implementation

final class ProfileRouterImpl: BaseRouter, ProfileRouter {

    // MARK: - Internal

    var viewController: UIViewController

    // MARK: - Init

    init(viewController: UIViewController, interactor: Interactor) {
        self.viewController = viewController
        super.init(interactor: interactor)
    }

}
