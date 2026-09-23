//
//  MileStone4App.swift
//  MileStone4
//
//  Created by Gojo Satoru on 25/8/25.
//

import SwiftUI
import SwiftData

@main
struct MileStone4App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
    }
}
