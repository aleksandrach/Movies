//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    @Published var errorMessage: String? = nil
    
    let service = MovieAPIService.shared
    
    @MainActor
    func getMovieDetails(movieId: Int) async {
        do {
            let response = try await service.getMovieDetails(movieId: movieId)
            movieDetails = response
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
