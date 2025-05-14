//
//  MVP_XPet_TechnologyApp.swift
//  MVP_XPet_Technology
//
//  Created by Nathan Zhang on 8/4/25.
//

import SwiftUI

@main
struct MVP_XPet_TechnologyApp: App {
    @StateObject private var session = UserSession()
    @AppStorage("hasOnboarded") private var hasOnboarded = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if !hasOnboarded {
                    WelcomeView {
                        hasOnboarded = true
                    }
                } else if !session.isLoggedIn {
                    SignupView();
                } else {
                    HomeView(name: session.name, petName: session.petName)
                }
            }
            .environmentObject(session)
            .animation(.default, value: session.isLoggedIn)
        }
    }
}

