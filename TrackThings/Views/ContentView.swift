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
    
    @Query var food: [Food]
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(food) { food in
                    NavigationLink(value: food) {
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
                .onDelete(perform: deleteFood)
            }
            .navigationTitle("TrackThings")
            .navigationDestination(for: Food.self) { foodItem in
                EditFoodView(food: foodItem, navigationPath: $path)
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
    
    func deleteFood(at offsets: IndexSet) {
        for offset in offsets {
            let food = food[offset]
            modelContext.delete(food)
        }
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
