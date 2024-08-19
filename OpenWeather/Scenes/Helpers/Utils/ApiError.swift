import Foundation

// MARK: Customs ApiErrors
enum ApiError: Error {
    case noConnection
    case invalidURL
    case decodingError
}
