

protocol MealRepositoryProtocol {
    func fetchMyMeals() async throws -> [Meal]
}
