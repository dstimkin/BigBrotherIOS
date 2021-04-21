import Foundation

final class TrackActivationBuilder: Builder {

    // MARK: - Private properties

    private let factory: TrackActivationComponentFactory

    // MARK: - Init

    init(factory: TrackActivationComponentFactory) {
        self.factory = factory
    }

    // MARK: - Internal methods

    func build() -> ViewableRouter {
        let component = factory.makeComponent()

        let interactor = TrackActivationInteractorImpl(hostProvider: component.serverHostStorage,
                                                       tokenProvider: component.tokenProvider,
                                                       contactsStorage: component.contactsStorage)
        let view = TrackActivationViewImpl()
        let router = TrackActivationRouterImpl(viewController: view,
                                               interactor: interactor)
        view.eventHandler = interactor
        interactor.view = view

        return router
    }
    
}

// MARK: - Component

extension TrackActivationBuilder {

    public struct Component {

        let serverHostStorage: ServerHostStorage
        let tokenProvider: TokenProvider
        let contactsStorage: ContactsStorage

    }

}

// MARK: - Component factory

protocol TrackActivationComponentFactory: AnyObject {

    func makeComponent() -> TrackActivationBuilder.Component

}

// MARK: - Protocol TrackActivationComponentFactory

extension RootServicesProvider: TrackActivationComponentFactory {

    func makeComponent() -> TrackActivationBuilder.Component {
        return .init(serverHostStorage: rootContainer.serverHostStorage,
                     tokenProvider: rootContainer.authenticationService,
                     contactsStorage: rootContainer.contactsStorage)
    }

}
