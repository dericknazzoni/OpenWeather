protocol CityWeatherInformationProtocol {
    // Creating the protocol so that inside my UnitTests i do not have to force unwrap anything
    func getTemp(city: String, metric: String,_ completion: @escaping (Result<CityWeatherInformationModel, ApiError>) -> Void)
}
