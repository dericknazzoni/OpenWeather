import UIKit
import SwiftUI

struct WeatherInformationViewRepresetable: UIViewControllerRepresentable {
    typealias UIViewControllerType = WeatherinformationView
    var cityName: String
    var tempeture: Double
    var icon: String
    var unit: Unit?
    var date: Int
    var delegate: WeatherReloadActionProtocol?
    
    func makeUIViewController(context: Context) -> WeatherinformationView {
        return WeatherinformationView(cityName: cityName, tempeture: tempeture, icon: icon, unit: unit ?? .metric, date: date, delegate: delegate)
    }

    func updateUIViewController(_ uiViewController: WeatherinformationView, context: Context) {
        //Do nothing
    }
}
