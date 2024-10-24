import SwiftUI

struct DrawingChallengeView: View {
    @State private var lines: [Line] = []
    @State private var currentLine: Line?
    
    var body: some View {
        VStack {
            Text("Drawing Challenge")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            // Drawing canvas
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(.blue), lineWidth: 5)
                }
            }
            .background(Color.white)
            .border(Color.gray, width: 3)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newPoint = value.location
                        if currentLine == nil {
                            currentLine = Line(points: [newPoint])
                        } else {
                            currentLine?.points.append(newPoint)
                        }
                    }
                    .onEnded { _ in
                        if let line = currentLine {
                            lines.append(line)
                        }
                        currentLine = nil
                    }
            )
            .frame(maxWidth: 350, maxHeight: 400)
            
            // Clear Button
            Button(action: clearDrawing) {
                Text("Clear Drawing")
                    .fontWeight(.semibold)
                    .font(.title2)
                    .padding()
                    .frame(width: 250, height: 65)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding(.top, 30)
            }
            .padding()
        }
        .padding()
    }
    
    // Function to clear the drawing
    private func clearDrawing() {
        lines.removeAll()
    }
}

// Struct to represent a line drawn on the canvas
struct Line {
    var points: [CGPoint]
}

// Preview
struct DrawingChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingChallengeView()
    }
}
