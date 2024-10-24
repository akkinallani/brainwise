import SwiftUI
import Charts // Make sure to import Charts for graph functionality

struct ProgressView: View {
    @State private var dailyStreak: Int = 5 // Example streak value
    @State private var performanceData: [Int] = [80, 70, 90, 60, 85, 100, 95] // Example performance data

    var body: some View {
        NavigationView { // Wrap the entire view in a NavigationView
            ScrollView {
                VStack(spacing: 30) {
                    // Daily Streak Section
                    VStack {
                        Text("Daily Streak")
                            .font(.largeTitle)
                            .bold()
                            .multilineTextAlignment(.center) // Center align the heading
                        Text("\(dailyStreak) days 🎉")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                    }
                    .frame(width: 350, height: 120) // Set width and height for larger background
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .padding() // Add padding around the section

                    // Performance Graph Section
                    VStack {
                        Text("Performance")
                            .font(.largeTitle)
                            .bold()
                            .multilineTextAlignment(.center)
                        LineChart(data: performanceData)
                            .frame(height: 200)
                            .padding()
                            .background(Color.clear) // Clear background for the graph
                            .cornerRadius(10)
                    }
                    
                    // Other Metrics Section
                    GeometryReader { geometry in
                        VStack(spacing: 10) {
                            Text("Other Metrics")
                                .font(.largeTitle)
                                .bold()
                                .multilineTextAlignment(.center) // Center align the heading
                                .padding(.bottom, 20)
                            GridView {
                                // Example of various metrics
                                MetricCard(title: "Accuracy", value: "76%")
                                MetricCard(title: "Games Played", value: "10")
                                MetricCard(title: "Weekly Activity", value: "2 hours")
                                MetricCard(title: "Last Active", value: "Today")
                            }
                            .frame(width: geometry.size.width * 0.9) // Set width to 90% of the geometry reader's width
                        }
                        .frame(width: 350, height: 300) // Fixed width and height for Other Metrics
                        .background(Color.clear) // Clear background for the metrics section
                        .cornerRadius(10)
                        .padding() // Add padding around the section
                    }
                    .frame(height: 300) // Set a fixed height for GeometryReader
                }
                .padding()
                .navigationBarBackButtonHidden(true) // Hide back button
            }
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
                        
                        // Progress Button (current view)
                        Image(systemName: "chart.bar.fill")
                            .font(.title3)
                            .foregroundColor(.black)
                            .accessibility(label: Text("Progress"))
                        
                        Spacer()
                        
                        // Resources Button
                        NavigationLink(destination: ResourcesView()) {
                            Image(systemName: "book.fill")
                                .font(.title3)
                                .foregroundColor(.black)
                                .accessibility(label: Text("Resources"))
                        }
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
                    .padding(.top, 20)// Adjust padding as needed
                }
            }
            .navigationBarBackButtonHidden(true) // Hide back button on this view
        }
    }
}

struct MetricCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.top)
                .padding(.bottom, 7) // Add padding to the top of the title
                .multilineTextAlignment(.center) // Center align the title text
            Text(value)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .padding(.bottom) // Add padding to the bottom of the value
        }
        .frame(width: 150, height: 100) // Fixed width and height to prevent cutting off
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(5)
    }
}

struct GridView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(minimum: 150)), // Flexible width
            GridItem(.flexible(minimum: 150))  // Flexible width
        ], alignment: .center) { // Center align grid items
            content
        }
    }
}

// Sample Line Chart
struct LineChart: View {
    var data: [Int]

    var body: some View {
        Chart(data.indices, id: \.self) { index in
            LineMark(
                x: .value("Day", index + 1),
                y: .value("Performance", data[index])
            )
            .foregroundStyle(Color.blue)
        }
        .chartYAxisLabel("Performance (%)")
        .chartXAxisLabel("Day")
        .background(Color.clear) // Ensure the background is clear
        .padding(.bottom, -80)
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
