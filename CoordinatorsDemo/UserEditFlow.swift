import RxFlow

class UserEditFlow: Flow {
    var root: Presentable {
        return rootViewController
    }
    private let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MyStep else { return .none }
        
        switch step {
        case let .userEdit(user):
            return navigateToUserEditScreen(user: user)
        case .selectCity:
            return navigateToCitiesScreen()
        case let .selectCityComplete(city):
            return navigateToSelectCityComplete(city: city)
        }
    }
}

// MARK: - Private
private extension UserEditFlow {
    func navigateToSelectCityComplete(city: City) -> FlowContributors {
        rootViewController.viewControllers.forEach {
            ($0 as? UpdateableWithUser)?.user?.city = city
        }
        rootViewController.popViewController(animated: true)
        return .none
    }
    
    func navigateToUserEditScreen(user: User) -> FlowContributors {
        let userEditController = UIStoryboard.makeUserEditController()
        userEditController.user = user
        rootViewController.pushViewController(userEditController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: userEditController, withNextStepper: userEditController))
    }
    
    func navigateToCitiesScreen() -> FlowContributors {
        let controller = UIStoryboard.makeCitiesController()
        rootViewController.pushViewController(controller, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: controller, withNextStepper: controller))
    }
}
