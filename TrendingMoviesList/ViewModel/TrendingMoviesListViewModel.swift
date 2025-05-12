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
    @Published var errorMessage: String? = nil
    
    @ObservedObject var favorites = Favorites.shared
    
    var favoriteMovies: [Movie] {
        movies.filter { favorites.contains($0) }
    }
    
    let service = MovieAPIService.shared
    
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
            } catch {
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
}
