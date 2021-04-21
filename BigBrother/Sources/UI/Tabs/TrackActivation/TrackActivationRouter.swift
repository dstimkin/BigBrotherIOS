import UIKit

// MARK: - Protocol

protocol TrackActivationRouter: ViewableRouter {

}

// MARK: - Implementation

final class TrackActivationRouterImpl: BaseRouter, TrackActivationRouter {

    // MARK: - Internal

    var viewController: UIViewController

    // MARK: - Init

    init(viewController: UIViewController, interactor: Interactor) {
        self.viewController = viewController
        super.init(interactor: interactor)
    }

}
