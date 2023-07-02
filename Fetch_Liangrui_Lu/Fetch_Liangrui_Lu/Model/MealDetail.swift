//
//  MealDetail.swift
//  Fetch_Liangrui_Lu
//
//  Created by Larry Lu on 2023/7/2.
//

import Foundation

struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    var ingredients: [String] = []
    var measures: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strDrinkAlternate, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube, strSource, strImageSource, strCreativeCommonsConfirmed, dateModified
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strCategory = try container.decode(String.self, forKey: .strCategory)
        strArea = try container.decode(String.self, forKey: .strArea)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decode(String.self, forKey: .strYoutube)
        strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
        strImageSource = try container.decodeIfPresent(String.self, forKey: .strImageSource)
        strCreativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)
        
        ingredients = try decodeDynamicValues(from: decoder, prefix: "strIngredient")
        measures = try decodeDynamicValues(from: decoder, prefix: "strMeasure")
    }
    
    private func decodeDynamicValues(from decoder: Decoder, prefix: String) throws -> [String] {
            var values: [String] = []

            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        let keys = container.allKeys.sorted { (key1, key2) -> Bool in
            let numberString1 = key1.stringValue.replacingOccurrences(of: prefix, with: "")
            let numberString2 = key2.stringValue.replacingOccurrences(of: prefix, with: "")
            
            if let number1 = Int(numberString1), let number2 = Int(numberString2) {
                return number1 < number2
            } else {
                return numberString1 < numberString2
            }
        }


            for key in keys {
                if key.stringValue.starts(with: prefix), let value = try container.decodeIfPresent(String.self, forKey: key) {
                    values.append(value)
                }
            }
        // print(values)
            return values
        }
}

struct DynamicCodingKey: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    init?(intValue: Int) {
        return nil
    }
}


