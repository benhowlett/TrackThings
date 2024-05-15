//
//  EditFoodView.swift
//  TrackThings
//
//  Created by Ben Howlett on 2024-05-15.
//

import SwiftUI
import SwiftData

struct EditFoodView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var food: Food
    @Binding var navigationPath: NavigationPath
    
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Name")
                    TextField("Name", text: $food.name)
                        .multilineTextAlignment(.trailing)
                }
                Picker("Meal", selection: $food.meal) {
                    ForEach(Meal.allCases) { meal in
                        Text(String(describing: meal))
                    }
                }
                HStack {
                    Text("Amount")
                    TextField("Portions", value: $food.portions, format: .number)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Section("Nutrition Info") {
                HStack {
                    Text("Calories")
                    TextField("Portion Calories", value: $food.portionCalories, format: .number)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
        .navigationTitle("Edit Food")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return EditFoodView(food: previewer.food, navigationPath: .constant(NavigationPath())).modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
