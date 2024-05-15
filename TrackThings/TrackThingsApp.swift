//
//  TrackThingsApp.swift
//  TrackThings
//
//  Created by Ben Howlett on 2024-05-13.
//

import SwiftUI
import SwiftData

@main
struct TrackThingsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Food.self)
    }
}
