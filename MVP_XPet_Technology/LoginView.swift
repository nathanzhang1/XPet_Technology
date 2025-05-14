//
//  LoginView.swift
//  MVP_XPet_Technology
//
//  Created by Nathan Zhang on 16/4/25.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @StateObject private var auth = AuthController()
    @EnvironmentObject var session: UserSession

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
                .frame(width: 300)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .frame(width: 300)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            Button("Log In") {
                Task { @MainActor in
                    await auth.login(username: username, password: password, session: session)
                }
            }
            .frame(width: 300, height: 44)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            HStack(spacing: 0) {
                Text("Don't have an account? ")
                    .foregroundColor(.primary)
                NavigationLink("Sign up", destination: SignupView())
                    .foregroundColor(.blue)
            }
            .font(.subheadline)
            
            if let error = auth.errorMessage {
                ErrorBannerView(message: error)
            }

            Spacer()
        }
        .navigationTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserSession())
    }
}
