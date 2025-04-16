import Vapor

struct SignupRequest: Content {
    var username: String
    var name: String
    var petName: String
    var password: String
}
