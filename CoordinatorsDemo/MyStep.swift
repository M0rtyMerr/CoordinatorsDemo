import RxFlow

enum MyStep: Step {
    case userEdit(User)
    case selectCity
    case selectCityComplete(City)
}
