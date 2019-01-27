import UIKit
import RxFlow
import RxCocoa

final class UserEditViewController: UIViewController, UpdateableWithUser, Stepper {
    // MARK: - Input -
    var user: User? { didSet { updateView() } }
    
    let steps = PublishRelay<Step>()
    @IBOutlet private weak var userLabel: UILabel?
    @IBAction private func selectCityTap(_ sender: UIButton) {
        steps.accept(MyStep.selectCity)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    private func updateView() {
        userLabel?.text = "User: \(user?.name ?? ""), \n"
                        + "City: \(user?.city?.name ?? "")"
    }
}
