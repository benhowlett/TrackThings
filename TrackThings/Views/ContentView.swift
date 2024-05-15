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
    @Query var food: [Food]
    
    var body: some View {
        NavigationStack {
            ForEach(food) { food in
                NavigationLink(value: food) {
                    List {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(food.name)
                                Text(food.getFormatedPortions())
                            }
                            Spacer()
                            Text(String(format: "%.0f", food.getTotalCalories()))
                        }
                    }
                }
            }
            .navigationTitle("TrackThings")
            .toolbar {
                
            }
        }
    }
    
    func addFood() {
        let food = Food(name: "", portionCalories: 0, portions: 1)
        modelContext.insert(food)
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
