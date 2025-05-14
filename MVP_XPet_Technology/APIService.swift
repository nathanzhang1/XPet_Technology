import Foundation

// MARK: – Request & Response Models

struct SignupRequest: Codable {
    let username: String
    let name: String
    let petName: String
    let password: String
}

struct LoginRequest: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let name: String
    let petName: String
}

struct ErrorResponse: Decodable {
    let error: String
}

// MARK: – Client-side Errors

/// Wraps both server-sent errors and client/network errors
enum APIError: LocalizedError {
    case server(message: String)
    case badURL
    case decoding
    case unknown

    var errorDescription: String? {
        switch self {
        case .server(let msg): return msg
        case .badURL:         return "Bad URL"
        case .decoding:       return "Invalid response from server."
        case .unknown:        return "Something went wrong."
        }
    }
}

// MARK: – HTTP Service

enum APIService {
    static let baseURL = "http://localhost:8080"

    static func signup(_ data: SignupRequest) async throws {
        guard let url = URL(string: "\(baseURL)/signup") else {
            throw APIError.badURL
        }

        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONEncoder().encode(data)

        let (payload, resp) = try await URLSession.shared.data(for: req)
        guard let http = resp as? HTTPURLResponse else {
            throw APIError.unknown
        }

        switch http.statusCode {
        case 200:
            // success, nothing to decode
            return

        default:
            // try to decode server’s JSON error
            if let err = try? JSONDecoder().decode(ErrorResponse.self, from: payload) {
                throw APIError.server(message: err.error)
            } else {
                throw APIError.unknown
            }
        }
    }

    static func login(_ data: LoginRequest) async throws -> LoginResponse {
        guard let url = URL(string: "\(baseURL)/login") else {
            throw APIError.badURL
        }

        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONEncoder().encode(data)

        let (payload, resp) = try await URLSession.shared.data(for: req)
        guard let http = resp as? HTTPURLResponse else {
            throw APIError.unknown
        }

        switch http.statusCode {
        case 200:
            return try JSONDecoder().decode(LoginResponse.self, from: payload)

        default:
            if let err = try? JSONDecoder().decode(ErrorResponse.self, from: payload) {
                throw APIError.server(message: err.error)
            } else {
                throw APIError.unknown
            }
        }
    }
}
