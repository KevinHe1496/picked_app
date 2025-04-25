import SwiftUI
import PhotosUI

//MARK: Vista de crear un nuevo plato para un restaurante
struct CreateMealView: View {
    
    @Environment(AppStateVM.self) private var appState
    
    //Estado del formulario
    @State var name = ""
    @State var info = ""
    @State var price = ""
    @State var units = ""
    @State var selectedType = ""

    @State private var pickerItem: PhotosPickerItem? = nil
    @State private var selectedPhotoData: Data?

    @State var viewModel: CreateMealViewModel
    @State private var navigateToMeals = false

    //Listado de tipos de comida disponibles
    let foodTypes = ["american", "asian", "indian", "italian", "mediterranean", "mexican", "vegan", "vegetarian", "other"]

    init(appState: AppStateVM) {
        _viewModel = State(initialValue: CreateMealViewModel(appState: appState))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    //Título de la pantalla
                    Text("Add dish")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                        .padding(.top, 20)

                    //Campo de texto para el nombre del plato
                    IconTextFieldView(iconName: "fork.knife", placeholder: "Meal Name", text: $name, keyboardType: .default)

                    //Campo de texto para la descripción del plato
                    HStack(alignment: .top) {
                        Image(systemName: "note.text")
                            .foregroundStyle(.secondaryColor)
                            .padding(.top, 12)
                        
                        ZStack(alignment: .topLeading) {
                            if info.isEmpty {
                                Text("Description")
                                    .foregroundColor(.gray)
                                    .padding(.top, 12)
                                    .padding(.leading, 8)
                            }
                        }
                        TextEditor(text: $info)
                            .frame(minHeight: 150)
                            .padding(5)
                    }
                    .padding(.horizontal)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    //Selector de tipo de comida
                    Menu {
                        ForEach(foodTypes, id: \.self) { type in
                            Button(type.capitalized) {
                                selectedType = type
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedType.isEmpty ? "Food Type" : selectedType.capitalized)
                                .foregroundColor(selectedType.isEmpty ? .gray : .black)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    //Campo de texto para las unidades
                    IconTextFieldView(iconName: "number", placeholder: "Units", text: $units, keyboardType: .numberPad)

                    //Campo de texto para el precio
                    IconTextFieldView(iconName: "dollarsign.circle.fill", placeholder: "Price", text: $price, keyboardType: .decimalPad)

                    //Selector de imagen del plato
                    VStack {
                        PhotosPicker(selection: $pickerItem, matching: .images) {
                            VStack {
                                Text("Hacer foto o foto de galería")
                                    .foregroundStyle(.secondaryColor)
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 60))
                                    .foregroundStyle(.secondaryColor)
                            }
                        }
                    }
                    .padding()
                    .frame(width: 200, height: 200)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    //Botón para añadir el plato
                    CustomButtonView(title: "Add", color: .secondaryColor) {
                        Task {
                            let _ = try await viewModel.createMeal(
                                name: name,
                                info: info,
                                price: price,
                                units: units,
                                type: selectedType,
                                photo: selectedPhotoData
                            )
                        }
                    }

                    //Mostrar error si ocurre
                    if let error = viewModel.errorMessage {
                        Text("\(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                .padding()
            }
            .scrollIndicators(.never)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryColor)

            //Actualizar la imagen seleccionada cuando cambie el picker
            .onChange(of: pickerItem) { _, newItem in
                Task {
                    if let selectedItem = newItem {
                        do {
                            if let data = try await selectedItem.loadTransferable(type: Data.self) {
                                self.selectedPhotoData = data
                                print("Image loaded with size: \(data.count) bytes")
                            }
                        } catch {
                            print("Error loading image: \(error)")
                        }
                    }
                }
            }

            //Mostrar alerta de éxito y navegar al listado de platos
            .alert(viewModel.successMessage, isPresented: $viewModel.showSuccessAlert) {
                Button("OK"){
                    navigateToMeals = true
                }
            }
            //Navegacion oculta al listado de platos
            NavigationLink(destination: RestaurantMealsView(), isActive: $navigateToMeals) {
                EmptyView()
            }
        }
    }
}

//MARK: Vista previa
#Preview {
    CreateMealView(appState: AppStateVM())
        .environment(AppStateVM())
}
