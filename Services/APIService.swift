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
    
    func searchMovies(query: String, page: Int) async throws -> SearchMoviesResponse
}

class APIService: MovieServiceProtocol {
    
    static let shared = APIService()
    
    func fetchTrendingMovies(page: Int) async throws -> TrendingMoviesResponse {
        let endpoint = APIEndpoints.trendingMovies
        
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
            "Authorization": "Bearer " + APIEndpoints.apiKey
        ]
        
        do {
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
        let endpoint = APIEndpoints.movieDetails + "\(movieId)"
        
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
            "Authorization": "Bearer " + APIEndpoints.apiKey
        ]
        
        do {
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
    
    func searchMovies(query: String, page: Int) async throws -> SearchMoviesResponse {
        let endpoint = APIEndpoints.searchMovies
        
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidURL
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "query", value: "\(query)")
        ]
        components.queryItems = (components.queryItems ?? []) + queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer " + APIEndpoints.apiKey
        ]
        
        do {
            let session = URLSession(configuration: .default)

            let (data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkingError.invalidResponse
            }
            
            // Proceed with decoding only if status code is 200
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decoded = try decoder.decode(SearchMoviesResponse.self, from: data)
            return decoded
        } catch {
            // Print out the error if the data fetching fails
            print("Error fetching data: \(error.localizedDescription)")
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
