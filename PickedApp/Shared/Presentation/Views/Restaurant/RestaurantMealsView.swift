import SwiftUI

//MARK: Vista de los platos del restaurante
struct RestaurantMealsView: View {
    
    @Environment(AppStateVM.self) var appState  //Estado global de la app
    @State var viewModel: RestaurantMealsViewModel  //ViewModel encargado de gestionar los platos
    @State private var isShowingCreateMeal = false  //Controla la navegación al formulario de creación de platos

    //Inicializador que permite inyectar un ViewModel personalizado (por defecto crea uno nuevo)
    init(viewModel: RestaurantMealsViewModel = RestaurantMealsViewModel(appState: AppStateVM())) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            VStack {
                
                //Cabecera con el nombre del restaurante y botón para añadir plato
                HStack {
                    Text("My Dishes")  //Este texto se puede hacer dinámico en el futuro
                        .font(.title)
                        .bold()

                    Spacer()

                    //Botón para navegar al formulario de nuevo plato
                    Button(action: {
                        isShowingCreateMeal = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.orange)
                    }
                }
                .padding()

                //Mostrar el estado actual de la app (cargando, error, datos)
                switch appState.status {
                case .loading:
                    //Indicador de carga
                    ProgressView("loading meals...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .error(let errorMsg):
                    //Mensaje de error
                    Text("Error: \(errorMsg)")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                default:
                    //Listado de platos del restaurante
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.meals) { meal in
                                MealRowView(meal: meal)  //Cada fila representa un plato
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            //Cargar los platos cuando aparece la vista
            .onAppear {
                Task {
                    await viewModel.loadMyMeals()
                }
            }
            //Botón para cerrar sesión en la barra de navegación
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        appState.closeSessionUser()
                    }) {
                        Image(systemName: "power.circle.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                }
            }
            //Navegación al formulario de nuevo plato
            .navigationDestination(isPresented: $isShowingCreateMeal) {
                CreateMealView(appState: appState)
            }
        }
    }
}

//MARK: Vista previa
#Preview {
    let sampleMeals: [Meal] = (1...9).map { i in
        Meal(
            id: UUID(),
            name: "Sample Dish \(i)",
            info: "Delicious and tasty meal number \(i)",
            units: 5,
            price: Float(i) * 3.5,
            photo: "/images/sample\(i).jpg"
        )
    }

    let mockViewModel = RestaurantMealsViewModel(appState: AppStateVM())
    mockViewModel.meals = sampleMeals

    return RestaurantMealsView(viewModel: mockViewModel)
        .environment(AppStateVM())
}
