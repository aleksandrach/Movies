//
//  TrendingMoviesListViewModel.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

class TrendingMoviesListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String? = nil
    
    let service = MovieAPIService.shared
    
    @MainActor
    func fetchTrendingMovies() async {
        do {
            let result = try await service.fetchTrendingMovies()
            movies = result
        } catch {
            // Debugging: Log the error
            print("Error fetching trending movies: \(error)")
            errorMessage = error.localizedDescription
        }
    }
}
