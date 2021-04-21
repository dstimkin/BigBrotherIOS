import Foundation

final class MainTabBarBuilder: Builder {

    // MARK: - Private properties

    private let factory: MainTabBarComponentFactory

    // MARK: - Init

    init(factory: MainTabBarComponentFactory) {
        self.factory = factory
    }

    // MARK: - Internal methods

    func build() -> ViewableRouter {
        let component = factory.makeComponent()

        let interactor = MainTabBarInteractorImpl(authenticationService: component.authenticationService,
                                                  userDataProvider: component.userDataProvider,
                                                  contactsStorage: component.contactsStorage)
        let view = MainTabBarViewImpl()
        let router = MainTabBarRouterImpl(servicesProvider: component.servicesProvider,
                                          viewController: view,
                                          interactor: interactor)
        interactor.router = router

        return router
    }

}

// MARK: - Component

extension MainTabBarBuilder {

    public struct Component {

        let servicesProvider: RootServicesProvider
        let authenticationService: AuthenticationService
        let userDataProvider: UserDataProvider
        let contactsStorage: ContactsStorage

    }

}

// MARK: - Component factory

protocol MainTabBarComponentFactory: AnyObject {

    func makeComponent() -> MainTabBarBuilder.Component

}

// MARK: - Protocol MainTabBarComponentFactory

extension RootServicesProvider: MainTabBarComponentFactory {

    func makeComponent() -> MainTabBarBuilder.Component {
        return .init(servicesProvider: self,
                     authenticationService: rootContainer.authenticationService,
                     userDataProvider: rootContainer.userDataProvider,
                     contactsStorage: rootContainer.contactsStorage)
    }

}
