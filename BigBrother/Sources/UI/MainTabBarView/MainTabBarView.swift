import Foundation
import UIKit

// MARK: - Protocol

protocol MainTabBarView: AnyObject {

    func createTrackActivationTab(view: UIViewController)
    func createScenarioTab(view: UIViewController)
    func createProfileTab(view: UIViewController)

    func discardTabs()

}

// MARK: - Implementation

final class MainTabBarViewImpl: UITabBarController, MainTabBarView {

    // Private types

    private typealias Localizable = String.Localized.Tabs

    private enum Constants {

        static var activationTab: UIImage? {
            return UIImage(named: "activation_tab")
        }

        static var scenarioTab: UIImage? {
            return UIImage(named: "scenario_tab")
        }

        static var personTab: UIImage? {
            return UIImage(named: "person_tab")
        }

    }

    // MARK: - Private properties

    private weak var trackActivationTab: UIViewController?
    private weak var scenarioTab: UIViewController?
    private weak var profileTab: UIViewController?

    // MARK: - Internal methods

    override func viewDidLoad() {

    }

    func createTrackActivationTab(view: UIViewController) {
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.tabBarItem = UITabBarItem(title: Localizable.trackActivationTab,
                                                       image: Constants.activationTab,
                                                       tag: 0)
        trackActivationTab = navigationController
        addTab(navigationController)
    }

    func createScenarioTab(view: UIViewController) {
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = UITabBarItem(title: Localizable.scenarioTab,
                                                       image: Constants.scenarioTab,
                                                       tag: 1)
        scenarioTab = navigationController
        addTab(navigationController)
    }

    func createProfileTab(view: UIViewController) {
        view.tabBarItem = UITabBarItem(title: Localizable.profileTab,
                                       image: Constants.personTab,
                                       tag: 2)
        profileTab = view
        addTab(view)
    }

    func discardTabs() {
        viewControllers = nil
    }

    // MARK: - Private methods

    private func addTab(_ tab: UIViewController) {
        if viewControllers == nil {
            viewControllers = [tab]
        }
        else {
            viewControllers?.append(tab)
        }
    }

}
