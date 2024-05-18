//
//  Food.swift
//  TrackThings
//
//  Created by Ben Howlett on 2024-05-13.
//

import Foundation
import SwiftData

@Model
class Food {
    let meals = ["Breakfast", "Lunch", "Dinner", "Snack"]
    var name: String
    var portionCalories: Float
    var portions: Float
    var time: Date
    var day: String
    var meal: String
    
    init(name: String, portionCalories: Float, portions: Float, time: Date = Date()) {
        self.name = name
        self.portionCalories = portionCalories
        self.portions = portions
        self.time = time
        self.day = String(time.description[...time.description.index(time.description.startIndex, offsetBy: 9)])
        
        switch Calendar.current.component(.hour, from: time) {
        case 4..<11:
            self.meal = "Breakfast"
            break
        case 11..<16:
            self.meal = "Lunch"
            break
        case 16..<22:
            self.meal = "Dinner"
            break
        default:
            self.meal = "Snack"
        }
        
    }
    
    func getTotalCalories() -> Float {
        portionCalories * portions
    }
    
    func getFormatedPortions() -> String {
        if round(portions) == portions {
            return String(format: "%.0f", portions)
        } else {
            return String("\(round(portions * 10) / 10)")
        }
    }
    
    static func selectedDayPredicate(date: Date, meal: String) -> Predicate<Food> {
        let selectedDay = String(date.description[...date.description.index(date.description.startIndex, offsetBy: 9)])
        return #Predicate<Food> { food in
            food.day == selectedDay && food.meal == meal
        }
    }
}

enum Meal: String, Codable, CaseIterable, Identifiable, CustomStringConvertible {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .breakfast:
            return "Breakfast"
        case .lunch:
            return "Lunch"
        case .dinner:
            return "Dinner"
        case .snack:
            return "Snack"
        }
    }
}
