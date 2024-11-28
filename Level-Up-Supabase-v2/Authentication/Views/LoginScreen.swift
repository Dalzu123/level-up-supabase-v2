import SwiftUI
import Combine
import Foundation
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
    Form {
        Section {
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            
            TextField("Password", text: $password)
              .textContentType(.emailAddress)
              .textInputAutocapitalization(.never)
              .autocorrectionDisabled()}

      Section {
        Button("Sign in") {
          signInButtonTapped()
        }
          Section {
               Button(action: {
                  isNewUser = true
              }) {
                  Text("Create An Account")
                      .font(.title)
                      .padding()
                      .foregroundColor(.white)
                      .background(Color.orange)
                      .cornerRadius(10)
              }
              .sheet(isPresented: $isNewUser) {
                  CreateAccountView()
              }
          }

        if isLoading {
          ProgressView()
        }}

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
    .onOpenURL(perform: { url in
      Task {
        do {
          try await supabase.auth.session(from: url)
        } catch {
          self.result = .failure(error)
        }
      }
    })
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
