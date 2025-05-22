import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Welcome section
                VStack(spacing: 16) {
                    Image(systemName: "heart.text.square.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color(hex: "4A90E2"))
                    
                    Text("Welcome to Supply!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "212529"))
                    
                    if !viewModel.currentUser.name.isEmpty {
                        Text("Hello, \(viewModel.currentUser.name)!")
                            .font(.title2)
                            .foregroundColor(Color(hex: "495057"))
                    }
                    
                    Text("Your supplement tracking journey starts here")
                        .font(.body)
                        .foregroundColor(Color(hex: "6C757D"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                // Quick actions
                VStack(spacing: 16) {
                    Button(action: {
                        // TODO: Navigate to add supplement
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                            Text("Add Your First Supplement")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "4A90E2"))
                        .cornerRadius(12)
                    }
                    
                    Button(action: {
                        // TODO: Navigate to profile
                    }) {
                        HStack {
                            Image(systemName: "person.circle")
                                .font(.title2)
                            Text("View Profile")
                                .font(.headline)
                        }
                        .foregroundColor(Color(hex: "4A90E2"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: "4A90E2"), lineWidth: 1)
                        )
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer()
                
                // User info summary
                if viewModel.currentUser.age > 0 {
                    VStack(spacing: 8) {
                        Text("Your Profile")
                            .font(.headline)
                            .foregroundColor(Color(hex: "212529"))
                        
                        HStack(spacing: 20) {
                            VStack {
                                Text("Age")
                                    .font(.caption)
                                    .foregroundColor(Color(hex: "6C757D"))
                                Text("\(viewModel.currentUser.age)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(hex: "212529"))
                            }
                            
                            if let height = viewModel.currentUser.heightInFeet, let inches = viewModel.currentUser.heightInInches {
                                VStack {
                                    Text("Height")
                                        .font(.caption)
                                        .foregroundColor(Color(hex: "6C757D"))
                                    Text("\(height)'\(inches)\"")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(hex: "212529"))
                                }
                            }
                            
                            if let weight = viewModel.currentUser.weightInPounds {
                                VStack {
                                    Text("Weight")
                                        .font(.caption)
                                        .foregroundColor(Color(hex: "6C757D"))
                                    Text("\(weight) lbs")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(hex: "212529"))
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color(hex: "F8F9FA"))
                    .cornerRadius(12)
                    .padding(.horizontal, 32)
                }
            }
            .padding(.vertical, 40)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    MainView()
        .environmentObject(SupplyViewModel())
} 