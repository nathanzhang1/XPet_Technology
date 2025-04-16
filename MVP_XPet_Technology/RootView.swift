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
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RootView()
                .environmentObject({
                    let session = UserSession()
                    session.isLoggedIn = false
                    return session
                }())
        }
    }
}
