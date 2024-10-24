import SwiftUI

struct PhraseCompletionGame: View {
    // Define phrases and answer choices
    let phrases = [
        ("The early bird catches", ["the fish", "the worm", "the sun"], 1),
        ("Don't count your chickens before", ["they hatch", "they fly", "they grow"], 0),
        ("Every cloud has", ["rain", "a silver lining", "a rainbow"], 1),
        ("A blessing in", ["disguise", "trouble", "the sky"], 0),
        ("You can't judge a book by", ["its size", "its cover", "its price"], 1),
        ("Better late than", ["on time", "never", "tomorrow"], 1),
        ("Barking up the wrong", ["house", "tree", "idea"], 1),
        ("It takes two to", ["fight", "tango", "dance"], 1),
        ("Don't put all your eggs", ["in one basket", "in the fridge", "in one place"], 0),
        ("The grass is always greener", ["on the other side", "near the fence", "in the garden"], 0)
    ]
    
    // Game state
    @State private var currentPhraseIndex = 0
    @State private var showResult = false
    @State private var isCorrect = false
    
    var body: some View {
        VStack {
            Text("Complete the Phrase")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding()
            
            // Show the phrase with a blank to complete
            Text(phrases[currentPhraseIndex].0 + "...")
                .font(.title)
                .padding()
            
            // Display answer choices as buttons
            ForEach(0..<phrases[currentPhraseIndex].1.count, id: \.self) { index in
                Button(action: {
                    checkAnswer(selectedIndex: index)
                }) {
                    Text(phrases[currentPhraseIndex].1[index])
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                        .font(.title2)  // Make the text bigger
                        .padding(.horizontal)
                }
            }
            
            Spacer()
            
            // Show feedback
            if showResult {
                Text(isCorrect ? "Correct!" : "Wrong, try again.")
                    .font(.title2)
                    .padding()
                    .foregroundColor(isCorrect ? .green : .red)
                
                Button(action: {
                    nextPhrase()
                }) {
                    Text("Next")
                        .font(.title2)  // Make the button text bigger
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)  // Background color for the "Next" button
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding()
            }
        }
        .padding()
    }
    
    // Check if the selected answer is correct
    func checkAnswer(selectedIndex: Int) {
        isCorrect = selectedIndex == phrases[currentPhraseIndex].2
        showResult = true
    }
    
    // Move to the next phrase or loop back to the first
    func nextPhrase() {
        currentPhraseIndex = (currentPhraseIndex + 1) % phrases.count
        showResult = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PhraseCompletionGame()
    }
}
