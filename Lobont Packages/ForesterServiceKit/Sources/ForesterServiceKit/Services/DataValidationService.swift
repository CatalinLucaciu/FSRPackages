import SKUtils
import ForesterDomainKit

public final class DataValidationService: DataValidator {
    private let validator = SKValidator()
    
    public init() {}
    
    public func validateName(_ name: String) -> Bool {
        validator.validateFullName(name)
    }
    
    public func validateEmail(_ email: String) -> Bool {
        validator.validateEmail(email)
    }
    
    public func validatePassword(_ password: String) -> Bool {
        validator.validatePassword(password)
    }
}
