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
    @State var result: Result<Void, Error>?
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
                signInButtonTapped()
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
    func signInButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                try await supabase.auth.signInWithOTP(
                    email: email,
                    redirectTo: URL(string: "io.supabase.user-management://login-callback")
                )
                result = .success(())
            } catch {
                result = .failure(error)
            }
        }
    }
}


