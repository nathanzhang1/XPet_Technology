//
//  APIService.swift
//  MVP_XPet_Technology
//
//  Created by Nathan Zhang on 16/4/25.
//

import Foundation

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

enum APIService {
    static let baseURL = "http://localhost:8080"

    static func signup(_ data: SignupRequest) async throws {
        guard let url = URL(string: "\(baseURL)/signup") else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(data)

        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }

    static func login(_ data: LoginRequest) async throws -> LoginResponse {
        guard let url = URL(string: "\(baseURL)/login") else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(data)

        let (resultData, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.userAuthenticationRequired)
        }

        return try JSONDecoder().decode(LoginResponse.self, from: resultData)
    }
}
