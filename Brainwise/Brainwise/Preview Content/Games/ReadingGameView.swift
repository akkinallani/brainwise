import SwiftUI
import AVFoundation

struct DailyReadingView: View {
    @State private var currentPassage: String = ""
    private let synthesizer = AVSpeechSynthesizer() // Moved outside the function

    let passages = [
        "In a small village, an old man named Mr. Jenkins took care of a little bird with a broken wing. After a few weeks, the bird flew away but returned every day to visit him.",
        "Oliver, a wise owl, helped lost animals find their way home. One night, a rabbit named Ruby learned to trust her instincts with Oliver's guidance.",
        "Lily lived with her grandmother by a beautiful lake. They discovered a secret garden filled with colorful flowers, which they decided to care for together.",
        "Once upon a time, there was a little cat named Whiskers who loved to explore. One day, Whiskers found a hidden path in the woods that led to a sparkling pond where all the animals gathered to play.",
        "In a bustling city, a young boy named Sam built a treehouse in his backyard. Every weekend, he invited his friends over for adventures, where they imagined being pirates sailing across the ocean.",
        "A kind-hearted dog named Max spent his days helping people in his neighborhood. One winter, he found a lost kitten and brought it home, giving it a warm place to sleep until its owner was found.",
        "Emily, a gentle deer, lived in a beautiful forest filled with tall trees. She loved to share her favorite spots with her friends, especially the hidden meadow where colorful butterflies danced in the sunlight.",
        "At the edge of the village, a wise turtle named Shelly shared stories of the past with anyone who stopped to listen. Her tales taught everyone the importance of kindness and friendship.",
        "Every summer, a group of children gathered at the old oak tree to tell stories and play games. They felt the magic of their friendship as they shared laughter and made unforgettable memories.",
        "Once, in a quiet town, a young girl named Mia discovered a magical book in her attic. Whenever she read a story aloud, the characters would come to life, bringing joy and wonder to her world.",
        "In a cozy cottage, an elderly woman named Grandma Rose baked the best cookies. The aroma filled the air, and every time a child visited, she would share her treats and tell them stories from her childhood.",
        "One sunny day, a group of friends decided to build a fort using blankets and chairs. They created their secret hideout and spent hours playing pretend, dreaming of being superheroes saving the day.",
        "In a magical forest, a friendly fox named Finn helped a lost bunny find its way home. Together, they explored the wonders of nature, learning about the importance of helping each other.",
        "A curious squirrel named Bella loved to collect acorns. She shared her treasure with all her friends, teaching them the joy of giving and the beauty of friendship in their little forest community.",
        "In a world where dreams came true, a little girl named Clara wished for the ability to fly. One night, her dream became reality as she soared through the stars, discovering the beauty of the night sky."
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Daily Reading")
                .font(.largeTitle)
                .bold()
                .padding()

            Text(currentPassage)
                .font(.system(size: 24)) // Keeping original font size
                .padding(40)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                .multilineTextAlignment(.center) // Center the text

            HStack {
                Button(action: {
                    playAudio(for: currentPassage)
                }) {
                    Text("I don't understand, read aloud")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .padding(15)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()

                Button(action: {
                    // Generate a new passage when the user finishes reading
                    currentPassage = passages.randomElement() ?? ""
                }) {
                    Text("I finished reading, next story")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .padding(18)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .onAppear {
            // Select a random passage when the view appears
            currentPassage = passages.randomElement() ?? ""
            configureAudioSession() // Configure audio session on appear
        }
        .padding()
    }

    func playAudio(for text: String) {
        let utterance = AVSpeechUtterance(string: text)
        synthesizer.speak(utterance)
    }

    func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
}

struct DailyReadingView_Previews: PreviewProvider {
    static var previews: some View {
        DailyReadingView()
    }
}
