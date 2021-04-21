import Foundation

final class ScenarioBuilder: Builder {

    func build() -> ViewableRouter {
        let interactor = ScenarioInteractorImpl()
        let view = ScenarioViewImpl()
        let router = ScenarioRouterImpl(viewController: view, interactor: interactor)

        interactor.router = router
        interactor.view = view
        view.eventHandler = interactor

        return router
    }

}
