@testable import OpenWeather

extension CityWeatherInformationModel {
    static let fixture = CityWeatherInformationModel(
        weather: [
            .init(
                id: 801,
                main: "Clouds",
                description: "few clouds",
                icon: "02n"
            )
        ],
        main: .init(temp: 26.84),
        name: "Miami",
        dt: 1723968314,
        id: 2009435
    )
}
