import Foundation
import SwiftUI

struct MealDetailView: View {
    @StateObject var viewModel = MealDetailViewModel()
    let meal: Meal
    
    var body: some View {
        VStack {
            if let mealDetail = viewModel.meal {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Meal Image
                        AsyncImage(url: URL(string: mealDetail.strMealThumb)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.main.bounds.width - 32)
                                            .frame(maxWidth: .infinity)
                                            .cornerRadius(10)
                            case .failure(_):
                                // Placeholder or error handling
                                Color.gray
                                    .frame(width: UIScreen.main.bounds.width - 32)
                                    .cornerRadius(10)
                                    .overlay(
                                        Text("Error")
                                            .foregroundColor(.red)
                                    )
                            case .empty:
                                // Placeholder or loading indicator
                                Color.gray
                                    .frame(width: UIScreen.main.bounds.width - 32)
                                    .cornerRadius(10)
                                    .overlay(
                                        ProgressView()
                                    )
                            @unknown default:
                                // Placeholder or error handling
                                Color.gray
                                    .frame(width: UIScreen.main.bounds.width - 32)
                                    .cornerRadius(10)
                                    .overlay(
                                        Text("Unknown Error")
                                            .foregroundColor(.red)
                                    )
                            }
                        }
                        
                        // Meal Name
                        Text(mealDetail.strMeal)
                            .font(.title)
                            .bold()
                        
                        // Meal Name
                        Text("Instruction")
                            .font(.headline)
                            .bold()
                        
                        // Meal Instructions
                        Text(mealDetail.strInstructions)
                            .font(.body)
                        
                        // Ingredients
                        VStack(alignment: .leading) {
                            Text("Ingredients - Measures")
                                .font(.headline)
                                .padding(.vertical, 4)
                            
                            ForEach(Array(zip(mealDetail.ingredients, mealDetail.measures)), id: \.0) { ingredient, measure in
                                                            if (ingredient != "" && ingredient != " ") || (measure != "" && measure != " ") {
                                                                Text("\(ingredient) - \(measure)").font(.body)
                                                                    .padding(.vertical, 4)
                                                                    .padding(.horizontal, 8)
                                                                }
                                                        }
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            } else {
                ProgressView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(meal.strMeal)
        .onAppear {
            viewModel.fetchMealDetail(for: meal.idMeal)
        }
    }
}

