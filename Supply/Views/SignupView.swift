import SwiftUI

struct SignupView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showingLogin = false
    @State private var showingMainApp = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Background gradient - matches the design
            LinearGradient(
                colors: [Color(hex: "4A90E2"), Color(hex: "5BA3F5")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Section
                VStack(spacing: 8) {
                    Text("Signup")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Please Signup to Continue")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.top, 60)
                .padding(.bottom, 40)
                
                // Main Content Card
                VStack {
                    Spacer()
                    
                    // White card container
                    VStack(spacing: 24) {
                        VStack(spacing: 20) {
                            // Email Address Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email Address")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color(hex: "4A90E2"))
                                
                                TextField("yourname@email.com", text: $email)
                                    .textFieldStyle(AuthTextFieldStyle())
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                            }
                            
                            // Password Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color(hex: "4A90E2"))
                                
                                SecureField("••••••••", text: $password)
                                    .textFieldStyle(AuthTextFieldStyle())
                            }
                            
                            // Confirm Password Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Confirm Password")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color(hex: "4A90E2"))
                                
                                SecureField("••••••••", text: $confirmPassword)
                                    .textFieldStyle(AuthTextFieldStyle())
                            }
                        }
                        
                        // Sign Up Button
                        Button(action: {
                            // Handle signup action
                            handleSignup()
                        }) {
                            Text("Sign Up")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color(hex: "4A90E2"))
                                .cornerRadius(28)
                        }
                        .padding(.top, 8)
                        
                        // OR Divider
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(hex: "E9ECEF"))
                            
                            Text("OR")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "6C757D"))
                                .padding(.horizontal, 16)
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(hex: "E9ECEF"))
                        }
                        .padding(.vertical, 8)
                        
                        // Navigate to Login
                        Button(action: {
                            showingLogin = true
                        }) {
                            HStack {
                                Text("Already have an account?")
                                    .foregroundColor(Color(hex: "6C757D"))
                                Text("Login")
                                    .foregroundColor(Color(hex: "4A90E2"))
                                    .fontWeight(.semibold)
                            }
                            .font(.system(size: 14))
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(24)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
                    .padding(.horizontal, 24)
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showingLogin) {
            LoginView()
        }
        .navigationDestination(isPresented: $showingMainApp) {
            MainView()
        }
    }
    
    private func handleSignup() {
        // Basic validation
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            print("Please fill in all fields")
            return
        }
        
        guard password == confirmPassword else {
            print("Passwords do not match")
            return
        }
        
        // Complete signup through view model
        viewModel.completeSignup(email: email, password: password)
        
        // Navigate to main app
        showingMainApp = true
    }
}

// Custom text field style to match the design
struct AuthTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(hex: "4A90E2"), lineWidth: 1)
            )
            .cornerRadius(12)
    }
}

#Preview {
    NavigationView {
        SignupView()
            .environmentObject(SupplyViewModel())
    }
} 