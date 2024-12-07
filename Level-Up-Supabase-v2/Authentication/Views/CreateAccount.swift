//
//  Create_Account.swift
//  Level-Up
//
//  Created by Diego Alzugaray on 5/12/24.
//

import Supabase
import SwiftUI
import AuthenticationServices

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var errorMessage = ""
    @State private var successMessage = ""
    @State private var userId = UUID()
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        VStack {
            TextField("Username (Email)", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            

            Button("Sign Up") {
                Task {
                    do {
                        try await signUpWithEmail( password: password, username: username, firstName: firstName, lastName: lastName)
                        successMessage = "Sign-up successful!"
                        errorMessage = ""
                        authManager.isLoggedIn = true
                    } catch {
                        errorMessage = error.localizedDescription
                        successMessage = ""
                    }
                }
            }
            .padding()

            if !successMessage.isEmpty {
                Text(successMessage)
                    .foregroundColor(.green)
            }

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}


func signUpWithEmail(password: String, username: String, firstName: String, lastName: String) async throws {
    let client = SupabaseManager.shared.client
    
    
    // Create the user in Supabase Auth
    let signUpResult = try await client.auth.signUp(email: username, password: password)
    
     let userId = signUpResult.user.id
    
    // Insert additional user details into the `profiles` table
    let userProfile = UserProfile(userId: userId,
                                  username: username, firstName: firstName, lastName: lastName /*,password: password*/)
    try await client.from("profiles").insert(userProfile).execute()
    
    print("User signed up and profile created successfully!")
}


/*func signInWithApple() async throws {
    let client = SupabaseManager.shared.client

    // Create a request for Apple Sign-In
    let request = ASAuthorizationAppleIDProvider().createRequest()
    request.requestedScopes = [.fullName, .email]

    let controller = ASAuthorizationController(authorizationRequests: [request])
    controller.performRequests()

    controller.didCompleteWithAuthorization = { authorization in
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let identityToken = appleIDCredential.identityToken
            let tokenString = String(data: identityToken!, encoding: .utf8)
            
            Task {
                do {
                    let authResult = try await client.auth.signInWithIdToken(
                        idToken: tokenString!,
                        provider: "apple"
                    )

                    // Save additional user details (e.g., full name) to the `profiles` table
                    if let userId = authResult.user?.id, let fullName = appleIDCredential.fullName {
                        let userProfile: [String: Any] = [
                            "id": userId,
                            "username": "\(fullName.givenName ?? "") \(fullName.familyName ?? "")"
                        ]
                        try await client.from("profiles").insert(values: userProfile).execute()
                        print("User profile created for Apple Sign-In!")
                    }
                } catch {
                    print("Apple Sign-In failed: \(error.localizedDescription)")
                }
            }
        }
    }

    controller.didCompleteWithError = { error in
        print("Apple Sign-In failed: \(error.localizedDescription)")
    }
}
Usage in SwiftUI
Use an Apple Sign-In button:

swift
Copy code
struct AppleSignInButton: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}

struct LoginView: View {
    var body: some View {
        VStack {
            AppleSignInButton()
                .frame(height: 50)
                .onTapGesture {
                    Task {
                        try? await signInWithApple()
                    }
                }
        }
    }
}*/
