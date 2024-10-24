import SwiftUI

struct SupportView: View {
    @State private var showEmailConfirmation: Bool = false
    
    var body: some View {
        NavigationView {
                VStack(spacing: 25) {
                    Text("Support")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    // Support Team Email
                    supportBox(title: "Contact Our Support Team", content: {
                        VStack(alignment: .leading) {
                            Text("If you need assistance, feel free to email us at:")
                                .font(.body)
                                .font(.system(size: 18))
                            
                            Link("support@brainwise.com", destination: URL(string: "mailto:support@brainwise.com")!)
                                .font(.body)
                                .font(.system(size: 18))
                                .foregroundColor(.blue)
                                .padding(.vertical, 5)
                                .onTapGesture {
                                    showEmailConfirmation.toggle()
                                }
                        }
                    })

                    // Bug Reporting Section
                    supportBox(title: "Report a Bug", content: {
                        VStack(alignment: .leading) {
                            Text("If you encounter any issues while using the app, please report them:")
                                .font(.body)
                                .font(.system(size: 18))
                            
                            Link("Click here to report a bug", destination: URL(string: "https://yourapp.com/report-bug")!)
                                .font(.body)
                                .font(.system(size: 18))
                                .foregroundColor(.blue)
                        }
                    })

                    // Alzheimer's Association Helpline
                    supportBox(title: "Alzheimer's Helpline", content: {
                        VStack(alignment: .leading) {
                            Text("For immediate support, contact the Alzheimer's Association 24/7 Helpline:")
                                .font(.body)
                                .font(.system(size: 18))
                            
                            Text("1-800-272-3900")
                                .font(.body)
                                .font(.system(size: 18))
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    if let phoneUrl = URL(string: "tel://1-800-272-3900") {
                                        UIApplication.shared.open(phoneUrl)
                                    }
                                }
                        }
                    })

                    Spacer()
                    
                    // Copyright Section
                    Text("© 2024 Created by Akshat Nallani")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top, 90)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showEmailConfirmation) {
                Alert(title: Text("Email Sent"), message: Text("Your email has been sent to our support team."), dismissButton: .default(Text("OK")))
            }
        
    }

    // Helper function to create a consistent support box
    private func supportBox<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .bold()
            
            content()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal) // Apply horizontal padding to all boxes
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
