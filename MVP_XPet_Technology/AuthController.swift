//
//  AuthController.swift
//  MVP_XPet_Technology
//
//  Created by Nathan Zhang on 16/4/25.
//

import Foundation

class AuthController: ObservableObject {
    @Published var errorMessage: String?

    func signup(username: String, name: String, petName: String, password: String) async {
        let data = SignupRequest(username: username, name: name, petName: petName, password: password)
        do {
            try await APIService.signup(data)
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Signup failed: \(error.localizedDescription)"
            }
        }
    }

    func login(username: String, password: String, session: UserSession) async {
        let data = LoginRequest(username: username, password: password)

        do {
            let response = try await APIService.login(data)
            session.login(with: response)

        } catch {
            self.errorMessage = "Login failed: \(error.localizedDescription)"
        }
    }
}
