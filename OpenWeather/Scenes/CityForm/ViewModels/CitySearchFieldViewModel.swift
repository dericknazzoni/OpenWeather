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
        self.suggestions = []
        print("Error fetching city suggestions: \(error.localizedDescription)")
    }
}
