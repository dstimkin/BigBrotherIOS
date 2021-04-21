import Foundation

final class ScenarioDetailBuilder: Builder {

    // MARK: - Private properties

    private weak var listener: ScenarioDetailListener?

    // MARK: - Init

    init(listener: ScenarioDetailListener? = nil) {
        self.listener = listener
    }

    // MARK: - Internal methods

    func build(with scenario: Scenario) -> ViewableRouter {
        let view = ScenarioDetailViewImpl()
        let interactor = ScenarioDetailInteractorImpl(scenario: scenario, listener: listener)
        let router = ScenarioDetailRouterImpl(viewController: view,
                                              interactor: interactor)
        view.eventHandler = interactor
        interactor.view = view
        interactor.router = router

        return router
    }

}
