import SwiftUI

struct SignupView: View {
    @State private var username = ""
    @State private var name = ""
    @State private var petName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var formError: String?

    @StateObject private var auth = AuthController()
    @EnvironmentObject var session: UserSession
    @Environment(\.dismiss) private var dismiss
    
    private var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    // MARK: – Password rule checks
    private var isLongEnough: Bool { password.count >= 8 }
    private var hasUppercase: Bool { password.range(of: "[A-Z]", options: .regularExpression) != nil }
    private var hasDigit:    Bool { password.range(of: "[0-9]", options: .regularExpression) != nil }
    private var hasSpecial:  Bool { password.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil }
    private var passwordsMatch: Bool { !confirmPassword.isEmpty && password == confirmPassword }
    private var allRulesMet: Bool {
        isLongEnough && hasUppercase && hasDigit && hasSpecial && passwordsMatch
    }

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            // MARK: – Input fields
            Group {
                TextField("Username", text: $username)
                TextField("Your Name", text: $name)
                TextField("Pet Name", text: $petName)
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $confirmPassword)
            }
            .textFieldStyle(.roundedBorder)
            .frame(width: 300)
            .autocapitalization(.none)
            .disableAutocorrection(true)

            // MARK: – Password rules checklist
            VStack(alignment: .leading, spacing: 8) {
                RuleRow(text: "At least 8 characters", passed: isLongEnough)
                RuleRow(text: "1 uppercase letter", passed: hasUppercase)
                RuleRow(text: "1 number", passed: hasDigit)
                RuleRow(text: "1 special character", passed: hasSpecial)
                RuleRow(text: "Passwords match", passed: passwordsMatch)
            }
            .padding(.leading, 16)
            .frame(width: 300, alignment: .leading)

            // MARK: – Create Account button
            Button("Create Account") {
                Task { @MainActor in
                    formError = nil
                    auth.errorMessage = nil
                    
                    guard !username.isEmpty, !name.isEmpty, !petName.isEmpty else {
                        formError = "Please fill in username, name, and pet name."
                        return
                    }
                    guard allRulesMet else {
                        formError = "Please satisfy all password requirements above."
                        return
                    }
                    
                    await auth.signup(
                        username: username,
                        name: name,
                        petName: petName,
                        password: password
                    )
                    if auth.errorMessage == nil {
                        let response = LoginResponse(name: name, petName: petName)
                        session.login(with: response)
                        if !isPreview {
                            dismiss()
                        }
                    }
                }
            }
            .frame(width: 300, height: 44)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .buttonStyle(.borderedProminent)
            
            HStack(spacing: 0) {
                Text("Already have an account? ")
                    .foregroundColor(.primary)
                Button("Sign in") {
                    dismiss()
                }
                .foregroundColor(.blue)
            }
            .font(.subheadline)

            // MARK: – Error banners
            if let err = formError {
                ErrorBannerView(message: err)
            } else if let err = auth.errorMessage {
                ErrorBannerView(message: err)
            }

            Spacer()
        }
        .padding()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("Sign Up")
    }
}

private struct RuleRow: View {
    let text: String
    let passed: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: passed ? "checkmark.circle.fill" : "circle.fill")
                .foregroundColor(passed ? .green : .gray)
            Text(text)
                .foregroundColor(passed ? .green : .gray)
                .font(.subheadline)
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignupView()
        }
        .environmentObject(UserSession())
    }
}
