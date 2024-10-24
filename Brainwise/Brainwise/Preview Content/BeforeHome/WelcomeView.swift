import SwiftUI


struct WelcomeView: View {
    @State private var logoScale: CGFloat = 0.6 // Initial small size
    @State private var logoOpacity: Double = 0.0 // Initial opacity

    var body: some View {
        
        NavigationView{
            
            VStack {
                // Logo/Image Placeholder with Scaling and Fading Animation
                Image("brainwise") // Replace with your image asset
                    .resizable()
                    .scaledToFit()
                    .frame(width: 550, height: 550) // Adjust size as needed
                    .scaleEffect(logoScale) // Apply the scaling effect
                    .opacity(logoOpacity) // Apply opacity
                    .onAppear {
                        // Animate the scaling and opacity when the view appears
                        withAnimation(.easeInOut(duration: 1.5)) {
                            logoScale = 1.0 // Scale it up to full size
                            logoOpacity = 1.0 // Fade in to full opacity
                        }
                    }
                    .padding(.bottom, -100)
                    .padding(.top, -100)
                
                // Welcome Message
                Text("Welcome to Brainwise!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // Secondary Message
                Text("We're dedicated to changing lives through the power of technology and education.")
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 100)
                    .padding(.top, 5)
                
                // Get Started Button
                NavigationLink(destination: SignUpView()) {
                    Text("Get Started")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(width: 250)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding(.top, 30)
                }
                
                NavigationLink(destination: LoginView()) {
                    Text("Already Have An Account? Sign In")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(width: 450)
                        .foregroundColor(Color.blue)
                        .cornerRadius(10)
                        .padding(.top, 80)
                        .padding(.bottom, -40)
                }
                
                
                
            }
            .padding()
            .background(Color.white)
            .edgesIgnoringSafeArea(.bottom)
            .frame(width: 500)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
