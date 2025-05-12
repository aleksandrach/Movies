//
//  FavoritesView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = TrendingMoviesListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.favoriteMovies) { movie in
                NavigationLink(destination: {
                    
                }) {
                    MovieItemView(movie: movie)
                        .onAppear {
                            Task {
                                await viewModel.loadMoreMoviesIfNeeded(movies: viewModel.favoriteMovies, currentItem: movie)
                            }
                        }
                }
            }
            .listStyle(.plain)
            .padding(.vertical)
            .onAppear {
                Task {
                    await viewModel.fetchTrendingMovies()
                }
            }
            .navigationTitle("Trending Movies")
        }
    }
}

#Preview {
    FavoritesView()
}
