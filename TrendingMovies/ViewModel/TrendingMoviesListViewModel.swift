//
//  TrendingMoviesListViewModel.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation
import Combine
import SwiftUI

class TrendingMoviesListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    
    let service = APIService.shared
    
    private let repository: MovieRepository = CoreDataMovieRepository()

    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    
    @MainActor
    func loadMoreMoviesIfNeeded(currentItem: Movie?) async {
        guard let currentItem = currentItem else {
            await fetchTrendingMovies()
            return
        }
        
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        if movies.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            await fetchTrendingMovies()
        }
    }
    
    @MainActor
    func fetchTrendingMovies() async {
        guard !isLoading, currentPage <= totalPages else { return }
        isLoading = true
        
        do {
            let response = try await service.fetchTrendingMovies(page: currentPage)
            movies.append(contentsOf: response.results)
            totalPages = response.totalPages
            currentPage += 1
            repository.saveMovies(movies)
        } catch {
            print("API failed, loading cached trending")
            errorMessage = error.localizedDescription
            self.movies = repository.fetchCachedMovies()
        }
        
        isLoading = false
    }
}
