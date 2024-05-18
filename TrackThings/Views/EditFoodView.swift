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
                DatePicker(selection: $food.time, displayedComponents: [.date]) {
                    Text("Date")
                }
                Picker("Meal", selection: $food.meal) {
                    ForEach(food.meals, id: \.self) { meal in
                        Text(meal)
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
            Button("Save food") {
                saveFood()
            }
        }
        .navigationTitle("Edit Food")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func saveFood() {
        modelContext.insert(food)
        navigationPath.removeLast()
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
