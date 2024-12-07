import SwiftUI
import Combine

class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false

    func logIn() {
        // Simulate a login process
        isLoggedIn = true
    }

    func logOut() {
        // Simulate a logout process
        isLoggedIn = false
    }
}
