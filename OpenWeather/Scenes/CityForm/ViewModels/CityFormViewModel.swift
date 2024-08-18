import Foundation
import UIKit
import SwiftUI

enum Unit: String {
    case metric = "metric"
    case imperial = "imperial"
}

class CityFormViewModel: ObservableObject {
    // View Properties
    @Published var isLoading: Bool = true
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage = "An unknown error occurred."
    @Published var showForecast: Bool = false
    
    // Properties
    private let service: CityWeatherInformationProtocol
    var model: CityWeatherInformationModel?
    var unit: Unit?
    var system: Int = 0
    
    init(service: CityWeatherInformationProtocol = WeatherInformationService()) {
        self.service = service
    }
}
    
extension CityFormViewModel {
    func getForecast(city: String) {
        do {
            DispatchQueue.main.async {
                self.isLoading = true
                self.service.getTemp(city: city, metric: self.switchUnit()) { result in
                    switch result {
                    case let .success(model):
                        self.model = model
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.showForecast = true
                        }
                        print(model)
                        
                    case let .failure(error):
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.showErrorAlert = true
                        }
                        self.callAlertError(error)
                    }
                }
            }
        }
    }
    
    func switchUnit() -> String {
        if system == 0 {
            self.unit = .metric
            return Unit.metric.rawValue
        } else {
            self.unit = .imperial
            return Unit.imperial.rawValue
        }
    }
    
    func callAlertError(_ error: ApiError) {
        DispatchQueue.main.async {
            switch error {
            case .noConnection:
                self.errorMessage = "No internet connection"
            case .invalidURL:
                self.errorMessage = "Invalid City"
            case .decodingError:
                self.errorMessage = "Error to decode"
            }
        }
    }
    
    func didTapReloadButton() {
        getForecast(city: model?.name ?? "")
    }
}
