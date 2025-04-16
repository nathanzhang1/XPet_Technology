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

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
                   .environmentObject(session)
                   .animation(.default, value: session.isLoggedIn)
            }
        }
    }
}

