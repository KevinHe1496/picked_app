import SwiftUI

struct RestaurantMealsView: View {
    @Environment(AppStateVM.self) var appState
    @State var viewModel: RestaurantMealsViewModel

    init(viewModel: RestaurantMealsViewModel = RestaurantMealsViewModel(appState: AppStateVM())) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Restaurant Name")
                        .font(.title)
                        .bold()

                    Spacer()

                    Button(action: {
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.orange)
                    }
                }
                .padding()

                Text("My Dishes")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                switch appState.status {
                case .loading:
                    ProgressView("loading meals...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .error(let errorMsg):
                    Text("Error: \(errorMsg)")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                default:
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.meals) { meal in
                                MealRowView(meal: meal)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadMyMeals()
                }
            }
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
        }
    }
}
