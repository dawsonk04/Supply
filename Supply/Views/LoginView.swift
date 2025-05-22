import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    @State private var email = ""
    @State private var password = ""
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
                    Text("Login")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Please Login to Continue")
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
                        }
                        
                        // Login Button
                        Button(action: {
                            // Handle login action
                            handleLogin()
                        }) {
                            Text("Login")
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
                        
                        // Google Sign In Button
                        Button(action: {
                            // Handle Google sign in
                            handleGoogleSignIn()
                        }) {
                            HStack(spacing: 12) {
                                // Google Logo (using SF Symbol as placeholder)
                                Image(systemName: "globe")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(hex: "4285F4"))
                                
                                Text("Continue with Google")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color(hex: "495057"))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 28)
                                    .stroke(Color(hex: "E9ECEF"), lineWidth: 1)
                            )
                            .cornerRadius(28)
                        }
                        
                        // Back to Signup
                        Button(action: {
                            dismiss()
                        }) {
                            HStack {
                                Text("Don't have an account?")
                                    .foregroundColor(Color(hex: "6C757D"))
                                Text("Sign Up")
                                    .foregroundColor(Color(hex: "4A90E2"))
                                    .fontWeight(.semibold)
                            }
                            .font(.system(size: 14))
                        }
                        .padding(.top, 8)
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
        .navigationDestination(isPresented: $showingMainApp) {
            MainView()
        }
    }
    
    private func handleLogin() {
        // Basic validation
        guard !email.isEmpty, !password.isEmpty else {
            print("Please fill in all fields")
            return
        }
        
        // Complete login through view model
        viewModel.completeLogin(email: email, password: password)
        
        // Navigate to main app
        showingMainApp = true
    }
    
    private func handleGoogleSignIn() {
        // TODO: Implement Google Sign In
        print("Google Sign In attempted")
    }
}

#Preview {
    NavigationView {
        LoginView()
            .environmentObject(SupplyViewModel())
    }
} 