import UIKit
import CommonUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appDependencies: AppDependencies = AppDependencies()

    private lazy var appCoordinator: AppCoordinator = AppCoordinator(dependencies: appDependencies, uiEngineType: .uikit)
//    private lazy var appCoordinator: AppCoordinator = AppCoordinator(dependencies: appDependencies, uiEngineType: .swiftui)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        UINavigationBar.navigationBarColors(background: .systemBackground,
                                            titleColor: UIColor.dynamicColor(dark: .white, light: .black),
                                            tintColor: nil)

        appCoordinator.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
