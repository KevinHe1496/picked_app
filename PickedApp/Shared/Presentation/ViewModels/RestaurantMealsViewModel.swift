
import Foundation
import SwiftUI

@Observable
final class RestaurantMealsViewModel {
    private var appState: AppStateVM
    var errorMessage: String?
    var meals: [Meal] = []

    @ObservationIgnored
    private let useCase: MealUseCaseProtocol

    init(useCase: MealUseCaseProtocol = MealUseCase(), appState: AppStateVM) {
        self.useCase = useCase
        self.appState = appState
    }

    func loadMyMeals() async {
        appState.status = .loading
        errorMessage = nil

        do {
            meals = try await useCase.fetchMyMeals()
            appState.status = .loaded
        } catch {
            errorMessage = error.localizedDescription
            appState.status = .error(error: error.localizedDescription)
        }
    }
}
