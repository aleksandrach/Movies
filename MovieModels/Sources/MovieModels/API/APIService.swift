//
//  APIService.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

public enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unknown
}

public protocol MovieServiceProtocol {
    func fetchTrendingMovies(page: Int) async throws -> TrendingMoviesResponse
    
    func getMovieDetails(movieId: Int) async throws -> MovieDetails
    
    func searchMovies(query: String, page: Int) async throws -> SearchMoviesResponse
}

public final class APIService: MovieServiceProtocol, @unchecked Sendable {
    
    public static let shared = APIService()
    
    public func performRequest<T: Decodable>(
        endpoint: String,
        pathComponent: String? = nil,
        queryItems: [URLQueryItem] = []
    ) async throws -> T {
        var fullURLString = endpoint
        if let path = pathComponent {
            fullURLString += path
        }

        guard let url = URL(string: fullURLString) else {
            throw NetworkingError.invalidURL
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = (components.queryItems ?? []) + queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer " + APIEndpoints.apiKey
        ]

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidResponse
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error decoding: \(error.localizedDescription)")
            throw NetworkingError.invalidData
        }
    }
    
    public func fetchTrendingMovies(page: Int) async throws -> TrendingMoviesResponse {
        try await performRequest(
            endpoint: APIEndpoints.trendingMovies,
            queryItems: [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        )
    }
    
    public func getMovieDetails(movieId: Int) async throws -> MovieDetails {
        try await performRequest(endpoint: APIEndpoints.movieDetails,
                                 pathComponent: "\(movieId)",
                                 queryItems: [
                                    URLQueryItem(name: "language", value: "en-US")
                                 ]
        )
    }
    
    public func searchMovies(query: String, page: Int) async throws -> SearchMoviesResponse {
        try await performRequest(endpoint: APIEndpoints.searchMovies,
                                 queryItems: [
                                    URLQueryItem(name: "language", value: "en-US"),
                                    URLQueryItem(name: "page", value: "\(page)"),
                                    URLQueryItem(name: "query", value: "\(query)")
                                 ]
        )
    }
}
