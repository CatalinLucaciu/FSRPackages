import Foundation

public protocol AccountValidable {
    func validateName(_ name: String) -> Bool
    func validateEmail(_ email: String) -> Bool
    func validatePassword(_ password: String) -> Bool
}
