import Foundation


final class DefaultMealRepository: MealRepositoryProtocol {

    private var network: NetworkMealProtocol

    init(network: NetworkMealProtocol = NetworkMeal()) {
        self.network = network
    }

    func fetchMyMeals() async throws -> [Meal] {
        try await network.fetchMyMeals()
    }
    
    func createMeal(requestData: MealCreateRequest) async throws -> Meal {
        try await network.createMeal(requestData: requestData)
    }
}
