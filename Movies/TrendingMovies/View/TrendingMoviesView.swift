//
//  TrendingMoviesView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

struct TrendingMoviesView: View {
    @StateObject private var viewModel = TrendingMoviesListViewModel()
    
    var body: some View {
        MoviesListView(movies: viewModel.movies,
                       title: "Trending",
                       onItemAppear: { movie in
            Task {
                await viewModel.loadMoreMoviesIfNeeded(currentItem: movie)
            }
        }, onAppear: {
            Task {
                await viewModel.fetchTrendingMovies()
            }
        }, accessibilityPrefix: "trending")
    }
}

#Preview {
    TrendingMoviesView()
}
