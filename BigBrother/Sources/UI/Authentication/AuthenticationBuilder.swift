import Foundation

final class AuthenticationBuilder: Builder {

    // MARK: - Private properties

    private let factory: AuthenticationComponentFactory
    private weak var listener: AuthenticationListener?

    // MARK: - Init

    init(factory: AuthenticationComponentFactory, listener: AuthenticationListener?) {
        self.factory = factory
        self.listener = listener
    }

    // MARK: - Internal methods

    func build() -> ViewableRouter {
        let component = factory.makeComponent()

        let presenter = AuthenticationPresenterImpl()
        let view = AuthenticationViewImpl()
        let interactor = AuthenticationInteractorImpl(presenter: presenter,
                                                      authenticationService: component.authenticationService, serverHostStorage: component.serverHostStorage,
                                                      listener: listener)
        let router = AuthenticationRouterImpl(viewController: view,
                                              interactor: interactor)
        presenter.view = view
        presenter.interactor = interactor
        interactor.router = router
        view.eventHandler = presenter

        return router
    }

}

// MARK: - Component

extension AuthenticationBuilder {

    public struct Component {

        let authenticationService: AuthenticationService
        let serverHostStorage: ServerHostStorage

    }

}

// MARK: - Component factory

protocol AuthenticationComponentFactory: AnyObject {

    func makeComponent() -> AuthenticationBuilder.Component

}

// MARK: - Protocol AuthenticationComponentFactory

extension RootServicesProvider: AuthenticationComponentFactory {

    func makeComponent() -> AuthenticationBuilder.Component {
        return .init(authenticationService: rootContainer.authenticationService,
                     serverHostStorage: rootContainer.serverHostStorage)
    }

}
