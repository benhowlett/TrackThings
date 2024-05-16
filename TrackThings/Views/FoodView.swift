//
//  FoodView.swift
//  TrackThings
//
//  Created by Ben Howlett on 2024-05-16.
//

import SwiftUI
import SwiftData

struct FoodView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var food: [Food]
    
    var body: some View {
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
    }
    
    init(date: Date) {
        // This allows the view to only show the food items from the currently selected date
        _food = Query(filter: Food.selectedDayPredicate(date: date))
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
        return FoodView(date: Date()).modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
