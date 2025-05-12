//
//  APIService.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchTrendingMovies() async throws -> [Movie]
}

class MovieAPIService: MovieServiceProtocol {
    static let shared = MovieAPIService()
    
    func fetchTrendingMovies() async throws -> [Movie] {
        let endpoint = MoviesAPIEndpoints.trendingMovies
        
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(MoviesAPIEndpoints.apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkingError.invalidResponse
        }
        
        do {
            let decoded = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
            return decoded.results
        } catch {
            throw NetworkingError.invalidData
        }
    }
}

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unknown
}
