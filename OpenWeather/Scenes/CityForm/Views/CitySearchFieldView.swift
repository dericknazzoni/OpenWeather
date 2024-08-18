import SwiftUI
import MapKit

public struct CitySearchFieldView: View {
    @State private var isSuggestionSelected: Bool = false
    @State private var focus: Bool = true
    @StateObject private var viewModel = CitySearchFieldViewModel()

    var delegate: CitySearch?
        
    public var body: some View {
        VStack {
            TextField("Enter city name", text: $viewModel.searchQuery)
                .onChange(of: viewModel.searchQuery, {
                    searchCities()
                    focus = true
                })
                .padding(.bottom, 0)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit {
                    delegate?.searchCity(city: viewModel.searchQuery)
                }
            
            if !isSuggestionSelected || !viewModel.suggestions.isEmpty {
                List(viewModel.suggestions, id: \.self) { result in
                    Text(result)
                        .onTapGesture {
                            viewModel.suggestions = []
                            viewModel.searchQuery = result
                            isSuggestionSelected = true
                            focus = false
                        }
                }
                .listStyle(.plain)
            }
        }
        .padding()
    }
    
    private func searchCities() {
        if focus {
            viewModel.searchCities()
        }
    }
}
    
#Preview {
    CitySearchFieldView()
}
