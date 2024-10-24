import SwiftUI

struct HomeView: View {
    @State private var showHelp: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.trailing, 160)
                        .padding(.bottom, -20)
                    Spacer()
                    Button(action: {
                        showHelp.toggle()
                    }) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    .alert(isPresented: $showHelp) {
                        Alert(
                            title: Text("Help"),
                            message: Text("Select one of the featured activities below or navigate away using the icons!"),
                            dismissButton: .default(Text("Got it!"))
                        )
                    }
                }
                .padding(.leading, 10)

                Text("Good \(greetingBasedOnTime()), \(UserData.name)!")
                    .font(.title2)
                    .padding(.leading, -160)
                    .padding(.bottom, 20)

               
                ScrollView {
                    VStack(spacing: 10) {
                        Text("Featured Activities")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 0)
                            .padding()

                        activityRow(title: "Memory Game", description: "Test and improve your memory skills")
                        activityRow(title: "Math Puzzles", description: "Solve puzzles with your math skills")
                        activityRow(title: "Drawing Challenge", description: "Unleash your creativity with drawing")
                        activityRow(title: "Trivia Quiz", description: "Test your knowledge with fun trivia")
                        activityRow(title: "Phrase Completion", description: "Choose the word to complete the phrase")
                        
                        
                        activityRow(title: "Daily Reading", description: "Practice reading with daily stories")
                        
                    }
                    
                    .padding(.horizontal)
                }
                .frame(maxHeight: 600)
                Spacer()
            }
            .padding()
            .background(Color.white)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Image(systemName: "house.fill")
                            .font(.title3)
                            .foregroundColor(.black)
                            .accessibility(label: Text("Home"))
                            .disabled(true)

                        Spacer()
                        
                        NavigationLink(destination: ProgressView()) {
                            Image(systemName: "chart.bar.fill")
                                .font(.title3)
                                .foregroundColor(.black)
                                .accessibility(label: Text("Progress"))
                        }
                        Spacer()
                        
                        NavigationLink(destination: ResourcesView()) {
                            Image(systemName: "book.fill")
                                .font(.title3)
                                .foregroundColor(.black)
                                .accessibility(label: Text("Resources"))
                        }
                        Spacer()
                        
                        NavigationLink(destination: SupportView()) {
                            Image(systemName: "person.2.fill")
                                .font(.title3)
                                .foregroundColor(.black)
                                .accessibility(label: Text("Support"))
                        }
                    }
                    .padding(40)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)

    }

    private func activityRow(title: String, description: String) -> some View {
        VStack (spacing: 20){
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                NavigationLink(destination: destinationView(for: title)) {
                    Text("Start")
                        .fontWeight(.semibold)
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .frame(height: 100)
        }
        .padding(.horizontal)
    }

    private func destinationView(for title: String) -> some View {
        switch title {
        case "Memory Game":
            return AnyView(MemoryGameView())
        case "Math Puzzles":
            return AnyView(ContentViewMath())
        case "Drawing Challenge":
            return AnyView(DrawingChallengeView())
        case "Trivia Quiz":
            return AnyView(TriviaQuizView())
        case "Daily Reading":
            return AnyView(DailyReadingView())
        case "Phrase Completion":
            return AnyView(PhraseCompletionGame())
        default:
            return AnyView(Text("Activity not found"))
        }
    }

    private func greetingBasedOnTime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Morning"
        case 12..<17: return "Afternoon"
        default: return "Evening"
        }
    }
}






struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
