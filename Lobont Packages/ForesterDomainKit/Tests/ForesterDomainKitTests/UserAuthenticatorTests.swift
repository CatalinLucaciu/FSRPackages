import XCTest
@testable import ForesterDomainKit

final class UserAuthenticatorTests: XCTestCase {
    func test_register_and_login_user() async {
        let usersStub = makeUsersStub()
        let registererMock = makeRegistererMock(users: usersStub)
        let authenticationMock = makeAuthenticatorMock(users: usersStub)
        let databaseMock = makeDatabaseMock(users: usersStub)
        let sut = makeSUT(authenticator: authenticationMock, registerer: registererMock, databse: databaseMock)
        
        XCTAssertTrue(usersStub.users.isEmpty, "There should be no users before register")
        XCTAssertTrue(usersStub.databaseUsers.isEmpty, "There should be no users before register")
        
        do {
            _ = try await sut.login(withEmail: "test@email.com", password: "123456")
            XCTFail("Error needs to be thrown")
        } catch let error as ForesterError {
            XCTAssertTrue(error == .userNotFound)
        } catch {
            XCTFail("Error should be ForesterError")
        }
        
        try? await sut.register(withEmail: "test@email.com", password: "123456", name: "Andrei Lobont")
        XCTAssertTrue(usersStub.users.count > 0)
        
        do {
            _ = try await sut.login(withEmail: "test@email.com", password: "123456")
        } catch {
            XCTFail("Login should've been successful")
        }
    }
}

extension UserAuthenticatorTests {
    private func makeSUT(
        authenticator: Authenticator,
        registerer: Registerer,
        databse: UserDatabase
    ) -> UserAuthenticator {
        let sut = UserAuthenticator(
            authenticator: authenticator,
            registerer: registerer,
            database: databse
        )
        trackMemoryLeaks(sut)
        return sut
    }
    
    private func makeAuthenticatorMock(users: UsersStub) -> Authenticator {
        let authentication = AuthenticationServiceMock(users: users)
        trackMemoryLeaks(authentication)
        return authentication
    }
    
    private func makeRegistererMock(users: UsersStub) -> Registerer {
        let registration = RegistererServiceMock(users: users)
        trackMemoryLeaks(registration)
        return registration
    }
    
    private func makeDatabaseMock(users: UsersStub) -> UserDatabase {
        let database = DatabaseServiceMock(users: users)
        trackMemoryLeaks(database)
        return database
    }
    
    private func makeUsersStub() -> UsersStub {
        let stub = UsersStub()
        trackMemoryLeaks(stub)
        return stub
    }
}
