import Foundation
import SwiftUI

//MARK: ViewModel del formulario de creación de un nuevo plato
@Observable
final class CreateMealViewModel {
    
    private var appState: AppStateVM
    private var useCase: MealUseCaseProtocol
    
    var errorMessage: String?
    var showSuccessAlert: Bool = false
    var successMessage: String = ""
    var isLoading: Bool = false
    
    init(appState: AppStateVM, useCase: MealUseCaseProtocol = MealUseCase()) {
        self.appState = appState
        self.useCase = useCase
    }
    
    //Método para crear un nuevo plato con validación de datos
    func createMeal(
        name: String,
        info: String,
        price: String,
        units: String,
        type: String,
        photo: Data?
    ) async throws -> Bool {
        
        //Validar que los campos requeridos no estén vacíos
        guard !name.isEmpty, !price.isEmpty, !units.isEmpty else {
            errorMessage = "All fields are required."
            return false
        }
        
        //Validar que price y units sean valores numéricos válidos
        guard let priceFloat = Float(price), let unitsInt = Int(units) else {
            errorMessage = "Price and Units must be valid numbers."
            return false
        }
        
        //Resetear errores anteriores
        errorMessage = nil
        do {
            //Construir el objeto de datos para la solicitud
            let requestData = MealCreateRequest(
                name: name,
                info: info,
                units: unitsInt,
                price: priceFloat,
                type: type,
                photo: photo
            )
            
            let _ = try await useCase.createMeal(requestData: requestData)
                appState.status = .restaurantMeals
                isLoading = false
                return true
            } catch {
                appState.status = .error(error: "Incorrect form")
                isLoading = false
                return false
            }
            
        }
}
