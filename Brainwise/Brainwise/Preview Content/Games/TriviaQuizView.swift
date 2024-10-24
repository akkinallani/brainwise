import SwiftUI

struct TriviaQuizView: View {
    @State private var selectedDecade = "1960s"
    @State private var showDecadePicker = false
    
    @State private var selectedTopic = "Pop Culture"
    @State private var showTopicPicker = false
    
    @State private var questionIndex = 0
    @State private var score = 0
    @State private var isGameOver = false
    @State private var selectedAnswer: String? = nil

    let decades = ["1960s", "1980s", "2000s"]
    let topics = ["Pop Culture", "Politics", "Science"]
    
    // Define questions based on decade and topic
    let questionsByCategory: [String: [String: [(question: String, answers: [String], correctAnswer: String)]]] = [
        "1960s": [
            "Pop Culture": [
                ("Who starred in the 1963 film 'Cleopatra'?", ["Elizabeth Taylor", "Audrey Hepburn", "Sophia Loren"], "Elizabeth Taylor"),
                ("What was the name of the famous music festival in 1969?", ["Woodstock", "Monterey", "Isle of Wight"], "Woodstock"),
                ("Who released the song 'Hey Jude' in 1968?", ["The Beatles", "The Rolling Stones", "The Who"], "The Beatles")
            ],
            "Politics": [
                ("Who was the U.S. President in 1963?", ["John F. Kennedy", "Lyndon B. Johnson", "Richard Nixon"], "John F. Kennedy"),
                ("What year did the Cuban Missile Crisis occur?", ["1960", "1962", "1964"], "1962"),
                ("What political movement gained momentum in the 1960s?", ["Civil Rights Movement", "Feminist Movement", "Environmental Movement"], "Civil Rights Movement")
            ],
            "Science": [
                ("What major space event happened in 1969?", ["Moon Landing", "Sputnik Launch", "Voyager 1 Launch"], "Moon Landing"),
                ("Who discovered the structure of DNA in the early 1960s?", ["Watson and Crick", "Einstein", "Curie"], "Watson and Crick"),
                ("Which vaccine was introduced in the 1960s?", ["Polio Vaccine", "Measles Vaccine", "Tetanus Vaccine"], "Measles Vaccine")
            ]
        ],
        "1980s": [
            "Pop Culture": [
                ("Who directed 'E.T. the Extra-Terrestrial'?", ["Steven Spielberg", "George Lucas", "James Cameron"], "Steven Spielberg"),
                ("Which artist released 'Thriller' in 1982?", ["Michael Jackson", "Prince", "Madonna"], "Michael Jackson"),
                ("What was the top-grossing movie of 1985?", ["Back to the Future", "The Goonies", "Rocky IV"], "Back to the Future")
            ],
            "Politics": [
                ("Who was the U.S. President during most of the 1980s?", ["Ronald Reagan", "George H.W. Bush", "Jimmy Carter"], "Ronald Reagan"),
                ("What event symbolized the end of the Cold War in 1989?", ["Fall of the Berlin Wall", "Collapse of the USSR", "Cuban Missile Crisis"], "Fall of the Berlin Wall"),
                ("What war did the U.S. fight in the early 1980s?", ["Falklands War", "Grenada", "Iran-Iraq War"], "Grenada")
            ],
            "Science": [
                ("What new disease was identified in the 1980s?", ["AIDS", "H1N1", "Zika"], "AIDS"),
                ("Which space shuttle exploded in 1986?", ["Challenger", "Columbia", "Endeavour"], "Challenger"),
                ("What was the name of the first personal computer introduced in the 1980s?", ["Apple Macintosh", "IBM PC", "Atari"], "IBM PC")
            ]
        ],
        "2000s": [
            "Pop Culture": [
                ("Which artist released the album 'The Marshall Mathers LP' in 2000?", ["Eminem", "Dr. Dre", "Jay-Z"], "Eminem"),
                ("What film won Best Picture at the Oscars in 2003?", ["Chicago", "Lord of the Rings: The Two Towers", "Gladiator"], "Chicago"),
                ("Who starred in the 'Pirates of the Caribbean' series starting in 2003?", ["Johnny Depp", "Brad Pitt", "Tom Cruise"], "Johnny Depp")
            ],
            "Politics": [
                ("Who was U.S. President in 2008?", ["George W. Bush", "Barack Obama", "Bill Clinton"], "George W. Bush"),
                ("What event took place on September 11, 2001?", ["9/11 Terrorist Attacks", "Hurricane Katrina", "Stock Market Crash"], "9/11 Terrorist Attacks"),
                ("What war did the U.S. start in 2003?", ["Iraq War", "Afghanistan War", "Bosnian War"], "Iraq War")
            ],
            "Science": [
                ("What space mission landed on Mars in 2004?", ["Spirit and Opportunity", "Curiosity", "Pathfinder"], "Spirit and Opportunity"),
                ("What major breakthrough happened in human genetics in 2003?", ["Human Genome Project Completed", "CRISPR Discovery", "Stem Cell Research"], "Human Genome Project Completed"),
                ("What was the name of the first private company to send a spacecraft to the ISS in the 2000s?", ["SpaceX", "Blue Origin", "Virgin Galactic"], "SpaceX")
            ]
        ]
    ]
    
    var body: some View {
        VStack {
            if questionIndex == 0 {
                // Custom dropdown for selecting a decade
                Text("Select a Decade")
                    .font(.title)
                    .bold()
                    .padding()

                Button(action: {
                    showDecadePicker.toggle()
                }) {
                    HStack {
                        Text(selectedDecade)
                            .font(.largeTitle)
                        Image(systemName: "chevron.down") // Dropdown indicator
                    }
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                    .padding()
                    .foregroundColor(.black)
                }
                .sheet(isPresented: $showDecadePicker) {
                    VStack {
                        Text("Select a Decade")
                            .font(.largeTitle)
                            .bold()
                            .padding()

                        List(decades, id: \.self) { decade in
                            Button(action: {
                                selectedDecade = decade
                                showDecadePicker.toggle()
                            }) {
                                Text(decade)
                                    .font(.largeTitle)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                        }
                    }
                }
                
                // Custom dropdown for selecting a topic
                Text("Select a Topic")
                    .font(.title)
                    .bold()
                    .padding()

                Button(action: {
                    showTopicPicker.toggle()
                }) {
                    HStack {
                        Text(selectedTopic)
                            .font(.largeTitle)
                        Image(systemName: "chevron.down") // Dropdown indicator
                    }
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(10)
                    .padding()
                    .foregroundColor(.black)
                }
                .sheet(isPresented: $showTopicPicker) {
                    VStack {
                        Text("Select a Topic")
                            .font(.largeTitle)
                            .bold()
                            .padding()

                        List(topics, id: \.self) { topic in
                            Button(action: {
                                selectedTopic = topic
                                showTopicPicker.toggle()
                            }) {
                                Text(topic)
                                    .font(.largeTitle)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                        }
                    }
                }

                // "Start Game" button
                Button(action: {
                    questionIndex = 1 // Starts the game by going to the first question
                }) {
                    Text("Start Game")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding()
                }
                .disabled(selectedDecade.isEmpty || selectedTopic.isEmpty) // Disable if not selected
            } else if questionIndex <= questionsByCategory[selectedDecade]?[selectedTopic]?.count ?? 0 {
                // Question View
                let currentQuestion = questionsByCategory[selectedDecade]?[selectedTopic]?[questionIndex - 1]
                
                Text(currentQuestion?.question ?? "")
                    .font(.largeTitle)
                    .padding()
                    .multilineTextAlignment(.center)

                ForEach(currentQuestion?.answers ?? [], id: \.self) { answer in
                    Button(action: {
                        selectedAnswer = answer
                        if answer == currentQuestion?.correctAnswer {
                            score += 1
                        }
                        questionIndex += 1
                        if questionIndex > questionsByCategory[selectedDecade]?[selectedTopic]?.count ?? 0 {
                            isGameOver = true
                        }
                    }) {
                        Text(answer)
                            .font(.title) // Make the answer buttons readable
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .padding()
                    }
                }
            } else if isGameOver {
                // Game Over View
                Text("Game Over!")
                    .font(.largeTitle)
                    .padding()

                Text("Your Score: \(score)/\(questionsByCategory[selectedDecade]?[selectedTopic]?.count ?? 0)")
                    .font(.title)
                    .padding()

                Button(action: {
                    questionIndex = 0
                    score = 0
                    selectedAnswer = nil
                    isGameOver = false
                }) {
                    Text("Play Again")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(Color.red)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
        .padding()
    }
}

struct TriviaQuizView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaQuizView()
    }
}
