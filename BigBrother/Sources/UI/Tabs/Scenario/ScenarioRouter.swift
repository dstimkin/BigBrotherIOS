import UIKit

// MARK: - Protocol

protocol ScenarioRouter: ViewableRouter {

    func attachScenarioDetail(_ scenario: Scenario, listener: ScenarioDetailListener?)
    func detachScenarioDetail()

}

// MARK: - Implementation

final class ScenarioRouterImpl: BaseRouter, ScenarioRouter {

    // MARK: - Internal properties

    var viewController: UIViewController

    // MARK: - Private properties

    weak var scenarioDetailRouter: ViewableRouter?

    // MARK: - Init

    init(viewController: UIViewController, interactor: Interactor) {
        self.viewController = viewController
        super.init(interactor: interactor)
    }

    // MARK: - Internal methods

    func attachScenarioDetail(_ scenario: Scenario, listener: ScenarioDetailListener?) {
        let router = ScenarioDetailBuilder(listener: listener).build(with: scenario)
        scenarioDetailRouter = router
        attachChild(router)
        viewController.navigationController?.pushViewController(router.viewController, animated: true)
    }

    func detachScenarioDetail() {
        if let router = scenarioDetailRouter {
            detachChild(router)
            scenarioDetailRouter = nil
        }
        viewController.navigationController?.popViewController(animated: true)
    }

}
