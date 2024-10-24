import SwiftUI

struct ResourcesView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("Dementia Education Resources")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    // Converse with AI Button
                    NavigationLink(destination: AIView()) {
                        HStack {
                            
        
                            Text("Have A Specific Question? Converse with AI!")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "message.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .padding(25)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .frame(width: 320)
                    }
                    .padding()
                    .navigationBarBackButtonHidden(true) // Hide back button

                    

                    // Dementia Education Resources
             

                    // Learn More About Dementia
                    SectionHeader(title: "Learn More About Dementia")
                    ResourceLink(title: "Alzheimer's Association", url: "https://www.alz.org/")
                    ResourceLink(title: "National Institute on Aging", url: "https://www.nia.nih.gov/health/alzheimers")
                    ResourceLink(title: "Dementia Friendly America", url: "https://www.dfamerica.org/")
                    ResourceLink(title: "Understanding Dementia - YouTube", url: "https://www.youtube.com/watch?v=9X3CbeInB08")
                    ResourceLink(title: "Dementia Basics - WebMD", url: "https://www.webmd.com/alzheimers/what-is-dementia")

                    // For Families
                    SectionHeader(title: "For Families")
                    ResourceLink(title: "Caregiver Resources - Alzheimer's Association", url: "https://www.alz.org/care/alzheimers-dementia-caregiver-resources")
                    ResourceLink(title: "Understanding Alzheimer’s and Dementia - CDC", url: "https://www.cdc.gov/aging/aginginfo/alzheimers.htm")

                    // Volunteering/Social Impact Projects
                    SectionHeader(title: "Volunteering / Social Impact")
                    ResourceLink(title: "Volunteer with the Alzheimer's Association", url: "https://www.alz.org/volunteer")
                    ResourceLink(title: "Dementia Friends", url: "https://www.dementiafriends.org/")

                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        // Home button
                        NavigationLink(destination: HomeView()) {
                            Image(systemName: "house.fill")
                                .font(.title3)
                                .foregroundColor(.black)
                                .accessibility(label: Text("Home"))
                        }
                        Spacer()
                        
                        NavigationLink(destination: ProgressView()) {
                            Image(systemName: "chart.bar.fill")
                                .font(.title3)
                                .foregroundColor(.black)
                                .accessibility(label: Text("Progress"))
                        }
                        Spacer()
                        
                        // Resources Button
                            Image(systemName: "book.fill")
                                .font(.title3)
                                .foregroundColor(.black)
                                .accessibility(label: Text("Resources"))
                        
                        Spacer()
                        
                        // Support Button
                        NavigationLink(destination: SupportView()) {
                            Image(systemName: "person.2.fill")
                                .font(.title3)
                                .foregroundColor(.black)
                                .accessibility(label: Text("Support"))
                        }
                    }
                    .padding(40)
                    .padding(.top, 20) // Adjust padding as needed
                }
            }
        }
    }
}

// AI Chat View


// ChatGPT API Integration


// View for section headers
struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .padding(.top)
            .padding(.bottom, 5)
    }
}

// View for each resource link
struct ResourceLink: View {
    let title: String
    let url: String

    var body: some View {
        Link(destination: URL(string: url)!) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.blue)
                Spacer()
                Image(systemName: "arrow.right.circle.fill")
                    .foregroundColor(.blue)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle()) // Prevents the default button styling
    }
}

// Mock HomeView


struct ResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcesView()
    }
}
