import Fluent
import Vapor

final class User: Model, Content, @unchecked Sendable {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Field(key: "name")
    var name: String

    @Field(key: "petName")
    var petName: String

    @Field(key: "passwordHash")
    var passwordHash: String

    init() {}

    init(username: String, name: String, petName: String, passwordHash: String) {
        self.username = username
        self.name = name
        self.petName = petName
        self.passwordHash = passwordHash
    }
}
