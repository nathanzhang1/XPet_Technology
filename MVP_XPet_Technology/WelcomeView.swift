//
//  WelcomeView.swift
//  MVP_XPet_Technology
//
//  Created by Nathan Zhang on 13/5/25.
//

// WelcomeView.swift

import SwiftUI

struct WelcomeView: View {
    // This closure tells App when the user taps “Get started”
    let onGetStarted: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Spacer()

            // Main title
            Text("👋 Welcome to XPET.ID")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            Spacer()

            // Subtitles
            VStack(spacing: 20) {
                Text("Feeding your new pet shouldn't feel like guesswork.")
                Text("We're here to help your pet (and you!) feel confident, healthy, and on track.")
            }
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .padding(.horizontal, 40)

            Spacer()

            // Get started link
            Button(action: onGetStarted) {
                HStack {
                    Text("Get started")
                    Image(systemName: "arrow.right")
                }
                .font(.headline)
                .foregroundColor(.blue)
            }
            .padding(.bottom, 30)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView { }
    }
}
