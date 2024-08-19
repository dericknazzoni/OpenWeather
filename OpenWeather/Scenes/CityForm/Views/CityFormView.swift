import SwiftUI

struct CityFormView: View, CitySearch, WeatherReloadActionProtocol {
    @StateObject var viewModel = CityFormViewModel()
    var citySearchDelegate: CitySearch?
    var weatherReloadActionDelegate: WeatherReloadActionProtocol?
    
    var body: some View {
        ZStack {
            VStack {
                Image("weatherApp")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.9)
                    .frame(width: 200, height: 200, alignment: .top)
                    .padding(.top, 0)

                Text("Weather App")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)

                Picker(selection: $viewModel.system, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                    Text("°C").tag(0)
                    Text("°F").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.all, 15)
                
                CitySearchFieldView(delegate: self)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            .sheet(isPresented: $viewModel.showForecast) {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(.circular)
                } else {
                    WeatherInformationViewRepresetable(
                        cityName: viewModel.model?.name ?? "",
                        tempeture: viewModel.model?.main.temp ?? 0.00,
                        icon: viewModel.model?.weather[0].icon ?? "",
                        unit: viewModel.unit ?? Unit.metric,
                        date: viewModel.model?.dt ?? 0,
                        delegate: self
                    )
                }
            }
        }
        .background(.primaryBackGroundColor)
    }
    
    func searchCity(city: String) {
        viewModel.getForecast(city: city)
    }
    
    func didTapReloadButton() {
        viewModel.didTapReloadButton()
    }
}

#Preview {
    CityFormView()
}
