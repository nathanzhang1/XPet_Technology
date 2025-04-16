import Fluent
import Vapor
import PostgresKit

func routes(_ app: Application) throws {
    app.post("signup") { req async throws -> HTTPStatus in
        let signup = try req.content.decode(SignupRequest.self)
        req.logger.info("Decoded signup request: \(signup.username), pet: \(signup.petName)")

        let existing = try await User.query(on: req.db)
            .filter(\.$username == signup.username)
            .first()

        guard existing == nil else {
            throw Abort(.conflict, reason: "Username already exists")
        }

        let hashed = try Bcrypt.hash(signup.password)
        let user = User(username: signup.username, name: signup.name, petName: signup.petName, passwordHash: hashed)

        do {
            try await user.save(on: req.db)
        } catch let dbError as PostgresError where dbError.code == .uniqueViolation {
            throw Abort(.conflict, reason: "Username already exists")
        }

        return .ok
    }

    app.post("login") { req async throws -> LoginResponse in
        let login = try req.content.decode(LoginRequest.self)

        guard let user = try await User.query(on: req.db)
            .filter(\.$username == login.username)
            .first(),
              try Bcrypt.verify(login.password, created: user.passwordHash)
        else {
            throw Abort(.unauthorized, reason: "Invalid credentials")
        }

        return LoginResponse(name: user.name, petName: user.petName)
    }
}
