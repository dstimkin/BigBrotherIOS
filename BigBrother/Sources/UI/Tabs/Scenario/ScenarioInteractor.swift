import Foundation

// MARK: - Protocol

protocol ScenarioInteractor {

}

// MARK: - Implementation

final class ScenarioInteractorImpl: BaseInteractor, ScenarioInteractor {

    // MARK: - Internal properties

    weak var router: ScenarioRouter?
    weak var view: ScenarioView?

    override func start() {
        super.start()
        view?.updateData([.empty, .empty, .empty, .empty, .empty, .empty])
    }

    override func stop() {
        router?.detachScenarioDetail()
        super.stop()
    }

}

// MARK: - Protocol ScenarioViewEventHandler

extension ScenarioInteractorImpl: ScenarioViewEventHandler {

    func onSelectRow(with scenario: Scenario) {
        router?.attachScenarioDetail(scenario, listener: self)
    }

}

// MARK: - Protocol ScenarioDetailListener

extension ScenarioInteractorImpl: ScenarioDetailListener {

    func onScenarioDetailDidComplete() {
        router?.detachScenarioDetail()
    }

}
