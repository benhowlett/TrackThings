//
//  ContentView.swift
//  TrackThings
//
//  Created by Ben Howlett on 2024-05-13.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            FoodView()
                .navigationTitle("TrackThings")
                .navigationDestination(for: Food.self) { food in
                    EditFoodView(food: food, navigationPath: $path)
                }
                .toolbar {
                    Button("Add food", systemImage: "plus") {
                        addFood()
                    }
                }
        }
    }
    
    func addFood() {
        let newFood = Food(name: "", portionCalories: 0, portions: 1)
        modelContext.insert(newFood)
        path.append(newFood)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ContentView().modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
