import Foundation


protocol NetworkMealProtocol {
    func fetchMyMeals() async throws -> [Meal]
    //func createMeal(requestData: CreateMealRequest) async throws -> Meal
}

final class NetworkMeal: NetworkMealProtocol {
    
    func fetchMyMeals() async throws -> [Meal] {
        var meals = [Meal]()
        
        //Construir la URL para obtener los platos
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(EndPoints.myMeals.rawValue)" 
        guard let url = URL(string: urlCad) else {
            throw PKError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        //Añadir token JWT desde KeyChain
        let jwtToken = KeyChainPK().loadPK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.addValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw PKError.errorFromApi(statusCode: -1)
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Respuesta: \(responseString)")
            }
            
            guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
                throw PKError.errorFromApi(statusCode: httpResponse.statusCode)
            }
            
            let result = try JSONDecoder().decode([Meal].self, from: data)
            meals = result
            
        } catch {
            print("Error fetching plates: \(error)")
            throw error
        }
        
        return meals
    }
}
