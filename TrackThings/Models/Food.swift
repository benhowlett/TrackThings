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
    var name: String
    var portionCalories: Float
    var portions: Float
    var time: Date
    var day: String
    var meal: Meal
    
    init(name: String, portionCalories: Float, portions: Float, time: Date = Date()) {
        self.name = name
        self.portionCalories = portionCalories
        self.portions = portions
        self.time = time
        self.day = String(time.description[...time.description.index(time.description.startIndex, offsetBy: 9)])
        
        switch Calendar.current.component(.hour, from: time) {
        case 4..<11:
            self.meal = .breakfast
            break
        case 11..<16:
            self.meal = .lunch
            break
        case 16..<22:
            self.meal = .dinner
            break
        default:
            self.meal = .snack
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
    
    static func selectedDayPredicate(date: Date) -> Predicate<Food> {
        let selectedDay = String(date.description[...date.description.index(date.description.startIndex, offsetBy: 9)])
        return #Predicate<Food> { food in
            food.day == selectedDay
        }
    }
    
}

enum Meal: Codable, CaseIterable, Identifiable, CustomStringConvertible {
    case breakfast, lunch, dinner, snack
    
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
