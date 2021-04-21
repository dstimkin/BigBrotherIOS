import Foundation

final class ProfileBuilder: Builder {

    // MARK: - Private properties

    private weak var listener: ProfileListener?
    private let factory: ProfileComponentFactory

    // MARK: - Init

    init(factory: ProfileComponentFactory, listener: ProfileListener? = nil) {
        self.factory = factory
        self.listener = listener
    }

    func build() -> ViewableRouter {
        let component = factory.makeComponent()

        let interactor = ProfileInteractorImpl(userDataProvider: component.userDataProvider,
                                               listener: listener)
        let view = ProfileViewImpl()
        let router = ProfileRouterImpl(viewController: view,
                                       interactor: interactor)
        interactor.view = view
        view.eventHandler = interactor

        return router
    }

}

// MARK: - Component

extension ProfileBuilder {

    public struct Component {

        let userDataProvider: UserDataProvider

    }

}

// MARK: - Component factory

protocol ProfileComponentFactory: AnyObject {

    func makeComponent() -> ProfileBuilder.Component

}

// MARK: - Protocol ProfileComponentFactory

extension RootServicesProvider: ProfileComponentFactory {

    func makeComponent() -> ProfileBuilder.Component {
        return .init(userDataProvider: rootContainer.userDataProvider)
    }

}

