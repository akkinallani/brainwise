import SwiftUI

struct MemoryGameView: View {
    @State private var cards = Card.generatePairs().shuffled() // Shuffled card pairs
    @State private var selectedIndices: [Int] = [] // Track selected cards
    @State private var score: Int = 0 // Track score
    @State private var attempts: Int = 0 // Track attempts to display feedback
    @State private var showCelebration = false // Track whether to show celebration

    var body: some View {
        VStack { // Removed ZStack for simplicity
            // Title and Score
            Text("Memory Game")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)

            Text("Score: \(score) | Attempts: \(attempts)")
                .font(.title2)
                .padding(.top, 10)

            // Card Grid (3x4)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                ForEach(cards.indices, id: \.self) { index in
                    CardView(card: cards[index])
                        .onTapGesture {
                            cardTapped(at: index)
                        }
                }
            }
            .padding()

            Spacer()
        }
        .navigationBarTitle("", displayMode: .inline) // Set title for back navigation
        .navigationBarBackButtonHidden(false) // Ensure the back button is visible
        .onAppear {
            // Reset celebration state when the view appears
            showCelebration = false
        }

        // Pop-Up Celebration Message
        if showCelebration {
            celebrationPopup
                .transition(.scale) // Animate appearance
                .zIndex(1) // Ensure it overlays on top
        }
    }

    // Pop-Up Celebration View
    private var celebrationPopup: some View {
        VStack {
            Text("🎉 You Win! 🎉")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Full screen size
        .background(Color.black.opacity(0.5)) // Semi-transparent background
        .onTapGesture {
            showCelebration = false // Hide the popup on tap
        }
    }

    // Handle card taps
    private func cardTapped(at index: Int) {
        guard selectedIndices.count < 2, !cards[index].isMatched, !cards[index].isFaceUp else { return }

        // Flip the card
        cards[index].isFaceUp.toggle()
        selectedIndices.append(index)

        // If two cards are selected, check for a match
        if selectedIndices.count == 2 {
            attempts += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                checkForMatch()
            }
        }
    }

    // Check if the selected cards match
    private func checkForMatch() {
        let firstIndex = selectedIndices[0]
        let secondIndex = selectedIndices[1]

        if cards[firstIndex].content == cards[secondIndex].content {
            // It's a match, mark cards as matched
            cards[firstIndex].isMatched = true
            cards[secondIndex].isMatched = true
            score += 1
            
            // Check if all cards are matched
            if cards.allSatisfy({ $0.isMatched }) {
                showCelebration = true // Trigger celebration
            }
        } else {
            // No match, flip cards back over
            cards[firstIndex].isFaceUp = false
            cards[secondIndex].isFaceUp = false
        }

        // Clear selected cards
        selectedIndices.removeAll()
    }
}

// Card View
struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                Text(card.content)
                    .font(.largeTitle)
                    .foregroundColor(.black)
            } else {
                Rectangle()
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .frame(width: 100, height: 140) // Adjust card size for 3x4 grid
        .animation(.easeInOut)
    }
}

// Card Model
struct Card: Identifiable {
    let id = UUID()
    let content: String
    var isFaceUp = false
    var isMatched = false

    static func generatePairs() -> [Card] {
        let symbols = ["🍎", "🍌", "🍇", "🍊", "🍒", "🍓"]
        var cards = [Card]()
        for symbol in symbols {
            cards.append(Card(content: symbol))
            cards.append(Card(content: symbol))
        }
        return cards
    }
}

struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { // Wrap in NavigationView for preview
            MemoryGameView()
        }
    }
}
