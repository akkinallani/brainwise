//
//  MathGameApp.swift
//  MathGame
//

//

import SwiftUI
import FamilyControls




struct MathGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewMath()
        }
    }
}


// APP: Request Authorization




struct Worklog: App {
    let center = AuthorizationCenter.shared
    var body: some Scene {
        WindowGroup {
            VStack {}
                .onAppear {
                    Task {
                        do {
                            try await center.requestAuthorization(for: .individual)
                        } catch {
                            print("Failed to enroll Aniyah with error: \(error)")
                        }
                    }
                }
        }
    }
}
