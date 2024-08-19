import Foundation
import MapKit

class CitySearchFieldViewModel: NSObject, ObservableObject {
    @Published var searchQuery: String = ""
    @Published var suggestions: [String] = []
    
    private var searchCompleter: MKLocalSearchCompleter
    
    override init() {
        self.searchCompleter = MKLocalSearchCompleter()
        self.searchCompleter.resultTypes = .address
        super.init()
        self.searchCompleter.delegate = self
    }
    
    func searchCities() {
        searchCompleter.queryFragment = searchQuery
    }
}

extension CitySearchFieldViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let filteredResults = completer.results
            .map { $0.title }
        // Calling cleanCityName, it is a function that filters the responses i receive. So that when i pass it to the api call it goes in the correct format
            .map { cleanCityName(from: $0) }
            .filter { !$0.isEmpty }

        suggestions = filteredResults
    }
    
    private func cleanCityName(from title: String) -> String {
        let components = title.split { $0 == "," || $0 == "-" }
        guard let cityName = components.first else { return "" }
        return cityName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Cleaning suggestions
        self.suggestions = []
        print("Error fetching city suggestions: \(error.localizedDescription)")
    }
}
