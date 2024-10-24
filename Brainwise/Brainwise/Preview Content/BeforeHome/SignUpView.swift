import SwiftUI

struct SignUpView: View {
    @State private var dateOfBirth: Date = Date() // Default to today
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var selectedGender: String = "Select Gender"
    @State private var signUpSuccess: Bool = false // State variable for sign up success
    @State private var isDatePickerPresented: Bool = false // State for showing the date picker

    // Sample gender options for the dropdown
    let genders = ["Male", "Female", "Prefer not to say"]

    var body: some View {
            VStack(spacing: 20) {
                // Title
                Text("New User Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 60) // Add top padding to lower the text
                
                // Name Field
                TextField("Enter your name", text: Binding(
                    get: { UserData.name },
                    set: { UserData.name = $0 }
                ))
                .font(.system(size: 22)) // Larger font size
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .frame(width: 350, height: 80)
                
                // Gender Dropdown
                Menu {
                    ForEach(genders, id: \.self) { gender in
                        Button(action: {
                            selectedGender = gender
                        }) {
                            Text(gender)
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedGender)
                            .foregroundColor(selectedGender == "Select Gender" ? .gray : .black)
                            .font(.system(size: 22)) // Larger font size
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .frame(width: 350, height: 80)
                }
                
                // Date of Birth Button
                Button(action: {
                    showDatePicker()
                }) {
                    HStack {
                        Text("Date of Birth: \(formattedDate(dateOfBirth))")
                            .foregroundColor(.black)
                            .font(.system(size: 22)) // Larger font size
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .frame(width: 350, height: 80)
                }
                .sheet(isPresented: $isDatePickerPresented) {
                    VStack {
                        // Header with the formatted date
                        Text("Select Date of Birth")
                            .font(.title2)
                            .padding()
                        
                        // Date Picker
                        DatePicker("",
                                   selection: $dateOfBirth,
                                   in: ...Date(),
                                   displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden() // Hide the default label
                        .padding()
                        
                        // Done Button
                        Button(action: {
                            isDatePickerPresented = false
                        }) {
                            Text("Done")
                                .fontWeight(.semibold)
                                .padding()
                                .frame(width: 250, height: 60)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        }
                        .padding(.bottom)
                    }
                    .padding()
                }
                
                // Email Field
                TextField("Enter your email", text: $email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .frame(width: 350, height: 80)
                    .font(.system(size: 22))
                
                // Phone Number Field
                TextField("Choose a password", text: $password)
                    .keyboardType(.default)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .frame(width: 350, height: 80)
                    .font(.system(size: 22))
                
                // Sign Up Button
                Button(action: {
                    // Handle sign up action here
                    print("Signing up: \(UserData.name), \(dateOfBirth), \(email), \(password), \(selectedGender)")
                    
                    // Assuming sign up is successful, update the state variable
                    signUpSuccess = true
                }) {
                    Text("Sign Up")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .padding()
                        .frame(width: 250, height: 65) // Taller button
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding(.top, 10)
                        .padding(.bottom, 25)
                }
                
                // Navigation to Login View
                NavigationLink(destination: LoginView()) {
                    Text("Already have an account? Login")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(Color.blue)
                }
                
                // Navigation to Home View
                NavigationLink(destination: HomeView(), isActive: $signUpSuccess) {
                    EmptyView()
                }
                .hidden() // Hides the NavigationLink but keeps it active
                
                Spacer()
            }
            .padding(.top, 20)
            .navigationBarBackButtonHidden(true) // Hide back button on this view
        
    }

    // Format date as string for display
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }

    // Show date picker when field is tapped
    private func showDatePicker() {
        isDatePickerPresented.toggle()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
