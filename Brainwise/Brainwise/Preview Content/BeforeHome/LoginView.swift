import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @State private var emailOrPhone: String = ""
    @State private var password: String = ""
    @State private var loginSuccess: Bool = false // State variable for login success
    @State private var authenticationError: String? = nil // For handling authentication errors
    @State private var showAlert: Bool = false // State variable for alert presentation

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)

            // Email/Phone Number Field
            TextField("Enter your email or phone number", text: $emailOrPhone)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .frame(width: 350, height: 80)
                .font(.system(size: 22))

            // Password Field with Show/Hide Functionality
            HStack {
                if password.isEmpty {
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                        .frame(width: 350, height: 80)
                        .font(.system(size: 22))
                } else {
                    HStack {
                        TextField("Enter your password", text: $password)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                            .frame(width: 350, height: 80)
                            .font(.system(size: 22))
                        Button(action: {
                            // Toggle password visibility
                            password = ""
                        }) {
                            Image(systemName: "eye")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }

            // Login Button
            Button(action: {
                // Handle login action here
                print("Logging in with: \(emailOrPhone) and password: \(password)")
                
                // Assuming login is successful, update the state variable
                loginSuccess = true
            }) {
                Text("Login")
                    .fontWeight(.semibold)
                    .font(.title2)
                    .padding()
                    .frame(width: 250, height: 65)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding(.top, 30)
            }

            // Face ID Button
            Button(action: {
                authenticateWithFaceID()
            }) {
                HStack {
                    Image(systemName: "faceid")
                        .foregroundColor(.white)
                    Text("Login with Face ID")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .padding()
                        .foregroundColor(.white)
                }
                .frame(width: 280, height: 65)
                .background(Color.green)
                .cornerRadius(10)
            }
            .padding(.top, 10)

            // Navigation to Sign Up View
            NavigationLink(destination: SignUpView()) {
                Text("Don't have an account? Sign Up")
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(Color.blue)
            }

            // Navigation to Home View
            NavigationLink(destination: HomeView(), isActive: $loginSuccess) {
                EmptyView()
            }
            .hidden() // Hides the NavigationLink but keeps it active

            Spacer()
        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true) // Hide back button on this view
        .navigationBarHidden(true) // Hide the navigation bar
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Authentication Error"), message: Text(authenticationError ?? "An unknown error occurred."), dismissButton: .default(Text("OK")))
        }
    }

    // Face ID Authentication
    func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Log in with Face ID"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        // Authentication was successful, proceed to the home view
                        loginSuccess = true
                    } else {
                        // Handle error (e.g., display a message)
                        if let error = authError as? LAError {
                            switch error.code {
                            case .authenticationFailed:
                                self.authenticationError = "Authentication failed. Please try again."
                            case .userCancel:
                                self.authenticationError = "User canceled the authentication."
                            case .userFallback:
                                self.authenticationError = "User chose to enter password."
                            case .biometryNotAvailable:
                                self.authenticationError = "Face ID is not available."
                            case .biometryNotEnrolled:
                                self.authenticationError = "No Face ID is enrolled. Please set it up in Settings."
                            case .biometryLockout:
                                self.authenticationError = "Face ID is locked. Please try again later."
                            default:
                                self.authenticationError = error.localizedDescription
                            }
                        } else {
                            self.authenticationError = authError?.localizedDescription
                        }
                        self.showAlert = true // Show the alert for the error
                    }
                }
            }
        } else {
            // Device doesn't support Face ID or Touch ID
            self.authenticationError = error?.localizedDescription ?? "Face ID not available."
            self.showAlert = true // Show the alert for the error
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
