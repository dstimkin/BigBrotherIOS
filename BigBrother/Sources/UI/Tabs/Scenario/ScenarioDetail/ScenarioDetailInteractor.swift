import Foundation

// MARK: - Protocols

protocol ScenarioDetailInteractor: AnyObject {

}

protocol ScenarioDetailListener: AnyObject {

    func onScenarioDetailDidComplete()

}

// MARK: - Implementation

final class ScenarioDetailInteractorImpl: BaseInteractor,
                                          ScenarioDetailInteractor {

    // MARK: - Internal properties

    weak var router: ScenarioDetailRouter?
    weak var view: ScenarioDetailView?
    weak var listener: ScenarioDetailListener?

    // MARK: - Private properties

    private var scenario: Scenario

    // MARK: - Init

    init(scenario: Scenario, listener: ScenarioDetailListener? = nil) {
        self.scenario = scenario
        self.listener = listener
    }

    // MARK: - Internal methods

    override func start() {
        super.start()
        view?.configureForScenario(scenario)
    }

}

// MARK: - Protocol ScenarioDetailViewEventHandler

extension ScenarioDetailInteractorImpl: ScenarioDetailViewEventHandler {

    func onCompleteButtonTap() {
        listener?.onScenarioDetailDidComplete()
    }

}
