import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Internal properties

    var window: UIWindow?
    var servicesContainer: RootServicesContainer = RootServicesContainerImpl()

    // MARK: - Private properties

    private var mainRouter: ViewableRouter?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.isIdleTimerDisabled = true
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {_, _ in

        }

        if #available(iOS 13, *) {
            return true
        }

        let servicesProvider = RootServicesProvider(rootContainer: servicesContainer)
        let router = MainTabBarBuilder(factory: servicesProvider).build()
        mainRouter = router
        router.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = router.viewController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        typealias Localized = String.Localized.Notifications.AppWillTerminate

        let content = UNMutableNotificationContent()
        content.title = Localized.title
        content.body = Localized.subtitle
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
                                                        repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request)

        mainRouter?.stop()
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

