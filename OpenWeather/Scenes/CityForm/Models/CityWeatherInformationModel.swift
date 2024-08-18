import Foundation

// MARK: - WeatherInformationModel (Root Model)
struct CityWeatherInformationModel: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    let dt: Int
    let id: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
}
