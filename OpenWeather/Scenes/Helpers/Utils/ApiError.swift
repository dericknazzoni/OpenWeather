import Foundation

enum ApiError: Error {
    case noConnection
    case invalidURL
    case decodingError
}
