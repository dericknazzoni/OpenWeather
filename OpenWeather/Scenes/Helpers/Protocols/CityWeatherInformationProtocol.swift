protocol CityWeatherInformationProtocol {
    func getTemp(city: String, metric: String,_ completion: @escaping (Result<CityWeatherInformationModel, ApiError>) -> Void)
}
