import Foundation

protocol MealUseCaseProtocol {
    var repo: MealRepositoryProtocol { get set }
    func fetchMyMeals() async throws -> [Meal]
    func createMeal(requestData: MealCreateRequest) async throws -> Meal
}

final class MealUseCase: MealUseCaseProtocol {
    var repo: MealRepositoryProtocol

    init(repo: MealRepositoryProtocol = DefaultMealRepository()) {
        self.repo = repo
    }

    func fetchMyMeals() async throws -> [Meal] {
        return try await repo.fetchMyMeals()
    }
    
    func createMeal(requestData: MealCreateRequest) async throws -> Meal {
        try await repo.createMeal(requestData: requestData)
    }
}
