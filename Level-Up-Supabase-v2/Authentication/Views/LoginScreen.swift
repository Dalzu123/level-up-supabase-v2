import SwiftUI
import Combine
import Foundation
import AuthenticationServices
import Supabase

struct LoginScreen: View {
    @State var email = ""
    @State var password = ""
    @State var isLoading = false
    @State var isNewUser = false
    @State var newUser = false
    @State  var errorMessage: String = ""
    @State  var isLoggedIn: Bool = false
    @State  var user: User?
    @State var result: Result<Void, Error>?
    @State var isAuthenticated = false;
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        VStack {
            Image("LevelUpBanner")
                .resizable() // Allows the image to be resized
                .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
            //.frame(width: 800, height: 200) // Sets the frame size of the image
                .clipped()
                .padding()
            
            Form {
                Section {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    TextField("Password", text: $password)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                }
            }
            .onOpenURL(perform: { url in
                Task {
                    do {
                        try await supabase.auth.session(from: url)
                    } catch {
                        self.result = .failure(error)
                    }
                }
            })
            
            
            
            
            Button("Sign in") {
                Task {
                                        do {
                                            let user = try await signInWithEmail(email: email, password: password)
                                            isLoggedIn = true
                                            print("Logged in as \(user?.email ?? "unknown")")
                                        } catch {
                                            errorMessage = error.localizedDescription
                                            isLoggedIn = false
                                        }
                                    }
            }
            .font(.title)
            .padding(5)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(0)
            
            Button(action: {
                isNewUser = true
            }) {
                Text("Create An Account")
            }
            .font(.title)
            .padding(5)
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(0)
            .sheet(isPresented: $isNewUser) {
                SignUpView()
            }
            
            
            
            if let result {
                Section {
                    switch result {
                    case .success:
                        Text("Check your inbox.")
                    case .failure(let error):
                        Text(error.localizedDescription).foregroundStyle(.red)
                    }
                }
            }
            
        }
    }


    func signInWithEmail(email: String, password: String) async throws -> User? {
        let client = SupabaseManager.shared.client

        // Use the correct method for email/password sign-in
        let result = try await client.auth.signIn(email: email, password: password)


          user = result.user
        if user?.email != "" {
            print("Successfully logged in")
            authManager.isLoggedIn = true
        }
        else {
            print("Error logging into the app")
            authManager.isLoggedIn = false
        }


       // print("Signed in user: \(user.email ?? "Unknown email")")
        return user
    }
}


