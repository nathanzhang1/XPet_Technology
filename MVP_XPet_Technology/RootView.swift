//
//  RootView.swift
//  MVP_XPet_Technology
//
//  Created by Nathan Zhang on 16/4/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: UserSession

    var body: some View {
        Group {
            if session.isLoggedIn {
                HomeView(name: session.name, petName: session.petName)
            } else {
                LoginView()
            }
        }
        .onAppear {
            print("🌱 RootView sees isLoggedIn: \(session.isLoggedIn)")
        }
    }
}
