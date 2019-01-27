import UIKit
import RxFlow

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let coordinator = FlowCoordinator()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let navigationController = window?.rootViewController as? UINavigationController else { return true }
        let user = User(name: "Anton Nazarov", city: City(name: "Moscow"))
        coordinator.coordinate(flow: UserEditFlow(rootViewController: navigationController),
                               with: OneStepper(withSingleStep: MyStep.userEdit(user)))
        return true
    }
}
