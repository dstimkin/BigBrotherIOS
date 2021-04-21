import Foundation
import UIKit

// MARK: - Protocol

protocol MainTabBarRouter: ViewableRouter {

    func attachTrackActivationScreen()
    func attachScenarioScreen()
    func attachProfileScreen(listener: ProfileListener?)

    func detachTabs()

    func attachAuthenticationScreen(animated: Bool, listener: AuthenticationListener?)
    func detachAuthenticationScreen()

}

// MARK: - Implementation

final class MainTabBarRouterImpl: BaseRouter, MainTabBarRouter {

    // MARK: - Internal properties

    var viewController: UIViewController

    // MARK: - Private properties

    private let servicesProvider: RootServicesProvider
    private weak var authenticationRouter: ViewableRouter?
    private var mainTabBarView: MainTabBarView? {
        return viewController as? MainTabBarView
    }

    // MARK: - Init

    init(servicesProvider: RootServicesProvider,
         viewController: UIViewController,
         interactor: Interactor) {

        self.servicesProvider = servicesProvider
        self.viewController = viewController
        super.init(interactor: interactor)
    }

    // MARK: - Internal methods

    func attachTrackActivationScreen() {
        let router = TrackActivationBuilder(factory: servicesProvider).build()
        attachChild(router)
        mainTabBarView?.createTrackActivationTab(view: router.viewController)
    }

    func attachScenarioScreen() {
        let router = ScenarioBuilder().build()
        attachChild(router)
        mainTabBarView?.createScenarioTab(view: router.viewController)
    }

    func attachProfileScreen(listener: ProfileListener?) {
        let router = ProfileBuilder(factory: servicesProvider, listener: listener).build()
        attachChild(router)
        mainTabBarView?.createProfileTab(view: router.viewController)
    }

    func detachTabs() {
        detachChildren()
        mainTabBarView?.discardTabs()
    }

    func attachAuthenticationScreen(animated: Bool,
                                    listener: AuthenticationListener?) {

        let router = AuthenticationBuilder(factory: servicesProvider,
                                           listener: listener).build()
        authenticationRouter = router
        attachChild(router)
        router.viewController.modalPresentationStyle = .fullScreen
        viewController.present(router.viewController, animated: animated, completion: nil)

    }

    func detachAuthenticationScreen() {
        guard let authenticationRouter = authenticationRouter else {
            return
        }

        detachChild(authenticationRouter)
        self.authenticationRouter = nil
        viewController.dismiss(animated: true, completion: nil)
    }

}
