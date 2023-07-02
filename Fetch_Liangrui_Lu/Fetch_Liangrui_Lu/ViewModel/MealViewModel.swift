import Foundation
import Combine

import Foundation

class MealViewModel: ObservableObject {
    @Published var meals = MealModel()
    @Published var error: Error?
    
    func fetchMeals() {
        guard let url = createURL(with: "/filter.php", queryParameters: ["c": "Dessert"]) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.error = error
                    print("1")
                }
                return
            }
            DispatchQueue.main.async {
                do {
                   try self.meals.initList(from: data)
                } catch {
                    DispatchQueue.main.async {
                        print(error)
                        self.error = error
                    }
                }
            }}.resume()
    }
}
