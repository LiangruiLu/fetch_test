//
//  Model.swift
//  Fetch_Liangrui_Lu
//
//  Created by Larry Lu on 2023/7/1.
//

import Foundation

struct Meal: Codable, Identifiable {
    var id: String {
            idMeal
        }
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

struct MealModel: Codable {
    private(set) var meals: [Meal] = []
    
    mutating func initList(from data: Data) throws {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode([String: [Meal]].self, from: data)
        if let meals = decodedData["meals"] {
            self.meals = meals.sorted { $0.strMeal < $1.strMeal }
        }
    }
}
