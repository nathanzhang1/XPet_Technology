import Vapor

struct LoginRequest: Content {
    var username: String
    var password: String
}

struct LoginResponse: Content {
    var name: String
    var petName: String
}