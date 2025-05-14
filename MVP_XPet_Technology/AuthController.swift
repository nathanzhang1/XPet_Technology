import Foundation
import Combine

@MainActor
class AuthController: ObservableObject {
    @Published var errorMessage: String?

    func signup(username: String, name: String, petName: String, password: String) async {
        let req = SignupRequest(username: username, name: name, petName: petName, password: password)
        do {
            try await APIService.signup(req)
            // on success clear any previous error
            self.errorMessage = nil
        } catch let apiErr as APIError {
            // immediately set errorMessage while still on the main actor
            self.errorMessage = apiErr.localizedDescription
        } catch {
            self.errorMessage = "Signup failed: \(error.localizedDescription)"
        }
    }

    func login(username: String, password: String, session: UserSession) async {
        let req = LoginRequest(username: username, password: password)
        do {
            let response = try await APIService.login(req)
            self.errorMessage = nil
            session.login(with: response)
        } catch let apiErr as APIError {
            self.errorMessage = apiErr.localizedDescription
        } catch {
            self.errorMessage = "Login failed: \(error.localizedDescription)"
        }
    }
}
