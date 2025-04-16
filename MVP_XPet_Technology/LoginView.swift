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
    @State private var isShowingSignup = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Spacer()

                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)

                Button("Log In") {
                    // Add login action later
                }
                .frame(width: 300, height: 44)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                NavigationLink("Sign Up", destination: SignupView())
                    .frame(width: 300, height: 44)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                Spacer()
            }
            .navigationTitle("Login")
        }
    }
}

#Preview {
    LoginView()
}
