import Foundation

public final class AccountValidator: AccountValidable {
    private let dataValidator: DataValidator
    
    public init(dataValidator: DataValidator) {
        self.dataValidator = dataValidator
    }
    
    public func validateName(_ name: String) -> Bool {
        dataValidator.validateName(name)
    }
    
    public func validateEmail(_ email: String) -> Bool {
        dataValidator.validateEmail(email)
    }
    
    public func validatePassword(_ password: String) -> Bool {
        dataValidator.validatePassword(password)
    }
}
