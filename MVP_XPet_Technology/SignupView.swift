//
//  SignupView.swift
//  MVP_XPet_Technology
//
//  Created by Nathan Zhang on 16/4/25.
//

import SwiftUI

struct SignupView: View {
    @State private var username = ""
    @State private var name = ""
    @State private var petName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var passwordMismatchError: String?
    @StateObject private var auth = AuthController()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Group {
                TextField("Username", text: $username)
                TextField("Name", text: $name)
                TextField("Pet Name", text: $petName)
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $confirmPassword)
            }
            .textFieldStyle(.roundedBorder)
            .frame(width: 300)
            .autocapitalization(.none)
            .disableAutocorrection(true)

            Button("Create Account") {
                Task {
                    // Reset password error
                    passwordMismatchError = nil

                    guard password == confirmPassword else {
                        passwordMismatchError = "Passwords do not match"
                        return
                    }

                    await auth.signup(username: username, name: name, petName: petName, password: password)
                    if auth.errorMessage == nil {
                        dismiss()
                    }
                }
            }
            .frame(width: 300, height: 44)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            
            if let error = passwordMismatchError {
                Text(error)
                    .foregroundColor(.red)
            }

            if let error = auth.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            Spacer()
        }
        .navigationTitle("Sign Up")
    }
}

#Preview {
    SignupView()
}
