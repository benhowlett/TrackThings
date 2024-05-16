//
//  Previewer.swift
//  TrackThings
//
//  Created by Ben Howlett on 2024-05-13.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let food: Food
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Food.self, configurations: config)
        
        food = Food(name: "Homemade Pizza", portionCalories: 277, portions: 2.5, time: Date())
        
        container.mainContext.insert(food)
    }
}
