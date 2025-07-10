import Foundation

public final class UserAuthenticator: UserAuthenticable & UserRegistrable {
    private let authenticator: Authenticator
    private let registerer: Registerer
    private let database: UserDatabase
    
    public init(
        authenticator: Authenticator,
        registerer: Registerer,
        database: UserDatabase
    ) {
        self.authenticator = authenticator
        self.registerer = registerer
        self.database = database
    }
    
    public func login(withEmail email: Email, password: Password) async throws -> User {
        do {
            let loginUser = try await authenticator.login(email: email, password: password)
            if let user = try await database.getUserData(forID: loginUser.id) {
                return user
            } else {
                throw ForesterError.failedToFetchDatabaseData
            }
        } catch {
            throw error
        }
    }
    
    public func googleLogin() async throws -> User {
        let googleLoginResult = try await authenticator.googleLogin()
        guard let user = try await database.getUserData(forID: googleLoginResult.id) else {
            let newUser = createNewUser(
                name: googleLoginResult.name,
                email: googleLoginResult.email,
                id: googleLoginResult.id,
                authenticationType: .google
            )
            do {
                try await database.addUserData(data: newUser)
                return newUser
            } catch {
                throw error
            }
        }
        return user
    }
    
    public func appleLogin() async throws -> User {
        let appleLoginResult = try await authenticator.appleLogin()
        guard let user = try await database.getUserData(forID: appleLoginResult.id) else {
            let newUser = createNewUser(
                name: appleLoginResult.name,
                email: appleLoginResult.email,
                id: appleLoginResult.id,
                authenticationType: .apple
            )
            do {
                try await database.addUserData(data: newUser)
                return newUser
            } catch {
                throw error
            }
        }
        return user
    }
    
    public func register(
        withEmail email: Email,
        password: Password,
        name: Name
    ) async throws {
        let user = try await registerer.register(email: email, password: password)
        let newUser = createNewUser(
            name: name,
            email: email,
            id: user.id,
            authenticationType: .password
        )
        try await database.addUserData(data: newUser)
    }
    
    private func createNewUser(
        name: Name,
        email: Email,
        id: UserID,
        authenticationType: AuthenticationType
    ) -> User {
        User(
            id: id,
            name: name,
            email: email,
            profilePictureID: UserProfilePicture.Free.icon1.id,
            totalSteps: 0,
            lastSync: Date.now.timeIntervalSince1970,
            accountCreationTime: Date.now.timeIntervalSince1970,
            totalWalkedDistance: 0,
            burntCalories: 0,
            plantedTreesCount: 0,
            coinsCount: 0,
            authenticationType: authenticationType
        )
    }
}
