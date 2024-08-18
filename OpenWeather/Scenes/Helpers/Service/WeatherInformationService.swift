import Foundation
import Combine

class WeatherInformationService: CityWeatherInformationProtocol {
    private let baseURL: String = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey: String = "b35702d9c44d2526a9f3286192152d66"
    var cancellable: AnyCancellable?
    
    func getTemp(city: String, metric: String, _ completion: @escaping (Result<CityWeatherInformationModel, ApiError>) -> Void) {
        guard let url = URL(string: "\(baseURL)?q=\(city)&appid=\(apiKey)&units=\(metric)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: CityWeatherInformationModel.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { taskCompletion in
                switch taskCompletion {
                case .finished:
                    return
                case let .failure(error):
                    completion(.failure(.decodingError))
                    
                }
            } receiveValue: { data in
                completion(.success(data))
            }
    }
}
