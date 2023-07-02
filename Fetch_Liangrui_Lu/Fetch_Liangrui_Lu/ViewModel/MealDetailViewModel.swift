import Foundation
import Combine

import Foundation

class MealDetailViewModel: ObservableObject {
    @Published var meal: MealDetail?
    @Published var error: Error?
    
    func fetchMealDetail(for mealID: String) {
        guard let url = createURL(with: "/lookup.php", queryParameters: ["i": mealID]) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.error = error
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([String: [MealDetail]].self, from: data)
                if let meal = decodedData["meals"]?.first {
                    DispatchQueue.main.async {
                        self.meal = meal
                    }
                } else {
                    DispatchQueue.main.async {
                        self.error = NSError(domain: "Meal Detail not found", code: 0, userInfo: nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print(error)
                    self.error = error
                }
            }
        }.resume()
    }
}


