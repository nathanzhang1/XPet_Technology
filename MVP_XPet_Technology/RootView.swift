import SwiftUI

struct RootView: View {
  @EnvironmentObject var session: UserSession

  var body: some View {
    Group {
      if session.isLoggedIn {
        HomeView(name: session.name, petName: session.petName)
      } else {
        SignupView()
      }
    }
  }
}
// … your RootView code ends here …

// MARK: – Previews
struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      // Logged Out
      NavigationStack {
        RootView()
      }
      .environmentObject({
        let s = UserSession()
        s.isLoggedIn = false
        return s
      }())
      .previewDisplayName("Logged Out")

      // Logged In
      NavigationStack {
        RootView()
      }
      .environmentObject({
        let s = UserSession()
        s.isLoggedIn = true
        s.name = "Name"
        s.petName = "Petname"
        return s
      }())
      .previewDisplayName("Logged In")
    }
  }
}
