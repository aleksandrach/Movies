//
//  APIService.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchTrendingMovies(page: Int) async throws -> TrendingMoviesResponse
    
    func getMovieDetails(movieId: Int) async throws -> MovieDetails
}

class MovieAPIService: MovieServiceProtocol {
    
    static let shared = MovieAPIService()
    
    func fetchTrendingMovies(page: Int) async throws -> TrendingMoviesResponse {
        let endpoint = MoviesAPIEndpoints.trendingMovies
        
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidURL
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        components.queryItems = (components.queryItems ?? []) + queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDBjZGY0ZjE1ZWJlZTA3MjA1NTNmN2NkN2YyMmRhZiIsIm5iZiI6MTc0NjgxNjU1NC4xMjksInN1YiI6IjY4MWU0ZTJhMGY3MzM5MDQwNjljMmJiNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UaZpGO0iTbk5_pdg8DPm_hZac9ddPiMMpP1EpKrso9k"
        ]
        
        do {
            //let config = URLSessionConfiguration.default
            //config.protocolClasses = [LoggingURLProtocol.self] // Custom logging protocol class
            //let networkLogger = NetworkLogger()

            let session = URLSession(configuration: .default)

            let (data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkingError.invalidResponse
            }
            
            // Proceed with decoding only if status code is 200
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decoded = try decoder.decode(TrendingMoviesResponse.self, from: data)
            return decoded
        } catch {
            // Print out the error if the data fetching fails
            print("Error fetching data: \(error.localizedDescription)")
            throw NetworkingError.invalidData
        }
    }
    
    func getMovieDetails(movieId: Int) async throws -> MovieDetails {
        let endpoint = MoviesAPIEndpoints.movieDetails + "\(movieId)"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidURL
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US")
        ]
        components.queryItems = (components.queryItems ?? []) + queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDBjZGY0ZjE1ZWJlZTA3MjA1NTNmN2NkN2YyMmRhZiIsIm5iZiI6MTc0NjgxNjU1NC4xMjksInN1YiI6IjY4MWU0ZTJhMGY3MzM5MDQwNjljMmJiNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UaZpGO0iTbk5_pdg8DPm_hZac9ddPiMMpP1EpKrso9k"
        ]
        
        do {
            //let config = URLSessionConfiguration.default
            //config.protocolClasses = [LoggingURLProtocol.self] // Custom logging protocol class
            //let networkLogger = NetworkLogger()

            let session = URLSession(configuration: .default)

            let (data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkingError.invalidResponse
            }
            
            // Proceed with decoding only if status code is 200
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decoded = try decoder.decode(MovieDetails.self, from: data)
            return decoded
        } catch {
            // Print out the error if the data fetching fails
            print("Error fetching data: \(error.localizedDescription)")
            throw NetworkingError.invalidData
        }
    }
}

//class LoggingURLProtocol: URLProtocol {
//    override class func canInit(with request: URLRequest) -> Bool {
//        return true
//    }
//
//    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
//        return request
//    }
//
//    override func startLoading() {
//        print("Request: \(self.request)")
//        if let response = self.client as? HTTPURLResponse {
//            print("Response: \(response.statusCode)")
//        }
//        self.client?.urlProtocol(self, didLoad: Data()) // Send dummy response for now
//    }
//
//    override func stopLoading() {
//        // Handle stopping of loading
//    }
//}
//
//class NetworkLogger: NSObject, URLSessionDelegate {
//    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
//    }
//    
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
//        if let httpResponse = response as? HTTPURLResponse {
//            print("Received response with status code: \(httpResponse.statusCode)")
//        }
//        completionHandler(.allow)
//    }
//    
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data, completionHandler: @escaping () -> Void) {
//        print("Received data: \(data.count) bytes")
//        completionHandler()
//    }
//}

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unknown
}
