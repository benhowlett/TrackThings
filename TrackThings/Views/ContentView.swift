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
    @State private var date = Date()
    
    
    var body: some View {
        NavigationStack(path: $path) {
            FoodView(date: date)
                .navigationTitle("TrackThings")
                .navigationDestination(for: Food.self) { food in
                    EditFoodView(food: food, navigationPath: $path)
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Button("Previous date", systemImage: "chevron.backward") {
                                incrementDate(by: -1)
                            }
                            DatePicker(selection: $date, displayedComponents: [.date]) {}
                                .labelsHidden()
                            Button("Next date", systemImage: "chevron.forward") {
                                incrementDate(by: 1)                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add food", systemImage: "plus") {
                            addFood()
                        }
                    }
                }
        }
    }
    
    func addFood() {
        let newFood = Food(name: "", portionCalories: 0, portions: 1)
        path.append(newFood)
    }
    
    func incrementDate(by amount: Int) {
        date = Calendar.current.date(byAdding: .day, value: amount, to: date)!
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
