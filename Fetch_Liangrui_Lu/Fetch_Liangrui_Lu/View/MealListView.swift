import Foundation
import SwiftUI

struct MealListView: View {
    @StateObject var viewModel = MealViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.meals.meals) { meal in
                NavigationLink(destination: MealDetailView(meal: meal)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(5)
                            case .failure(_):
                                // Placeholder or error handling
                                Color.gray
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Text("Error")
                                            .foregroundColor(.red)
                                    )
                            case .empty:
                                // Placeholder or loading indicator
                                Color.gray
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        ProgressView()
                                    )
                            @unknown default:
                                // Placeholder or error handling
                                Color.gray
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Text("Unknown Error")
                                            .foregroundColor(.red)
                                    )
                            }
                        }
                        
                        Text(meal.strMeal)
                            .font(.headline)
                            .bold()
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Desserts")
        }
        .onAppear {
            viewModel.fetchMeals()
        }
        .overlay(Group {
            if let error = viewModel.error {
                ErrorView(error: error, retryAction: viewModel.fetchMeals)
            }
        })
    }
}
