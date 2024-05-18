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
    
    @Query var breakfast: [Food]
    @Query var lunch: [Food]
    @Query var dinner: [Food]
    @Query var snacks: [Food]
    
    var body: some View {
        List {
            Section("Breakfast") {
                ForEach(breakfast) { food in
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
                .onDelete(perform: deleteBreakfastItem)
            }
            Section("Lunch") {
                ForEach(lunch) { food in
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
                .onDelete(perform: deleteLunchItem)
            }
            Section("Dinner") {
                ForEach(dinner) { food in
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
                .onDelete(perform: deleteDinnerItem)
            }
            Section("Snacks") {
                ForEach(snacks) { food in
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
                .onDelete(perform: deleteSnackItem)
            }
        }
    }
    
    init(date: Date) {
        // This allows the view to only show the food items from the currently selected date
        _breakfast = Query(filter: Food.selectedDayPredicate(date: date, meal: "Breakfast"))
        _lunch = Query(filter: Food.selectedDayPredicate(date: date, meal: "Lunch"))
        _dinner = Query(filter: Food.selectedDayPredicate(date: date, meal: "Dinner"))
        _snacks = Query(filter: Food.selectedDayPredicate(date: date, meal: "Snack"))
    }
    
    func deleteBreakfastItem(at offsets: IndexSet) {
        for offset in offsets {
            let item = breakfast[offset]
            modelContext.delete(item)
        }
    }
    
    func deleteLunchItem(at offsets: IndexSet) {
        for offset in offsets {
            let item = lunch[offset]
            modelContext.delete(item)
        }
    }
    
    func deleteDinnerItem(at offsets: IndexSet) {
        for offset in offsets {
            let item = dinner[offset]
            modelContext.delete(item)
        }
    }
    
    func deleteSnackItem(at offsets: IndexSet) {
        for offset in offsets {
            let item = snacks[offset]
            modelContext.delete(item)
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
