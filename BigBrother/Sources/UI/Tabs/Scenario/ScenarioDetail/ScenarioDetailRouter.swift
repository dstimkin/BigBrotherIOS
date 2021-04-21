import UIKit

// MARK: - Protocol

protocol ScenarioDetailRouter: ViewableRouter {

}

// MARK: - Implementation

final class ScenarioDetailRouterImpl: BaseRouter, ScenarioDetailRouter {

    // MARK: - Internal

    var viewController: UIViewController

    // MARK: - Init

    init(viewController: UIViewController, interactor: Interactor) {
        self.viewController = viewController
        super.init(interactor: interactor)
    }

}
