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

            Button("Make a New Account") {
                // Add sign up logic later
            }
            .frame(width: 300, height: 44)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)

            Spacer()
        }
        .navigationTitle("Sign Up")
    }
}


#Preview {
    SignupView()
}
