//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation
import MovieModels

class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    @Published var errorMessage: String?
    
    let service = APIService.shared
    
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
