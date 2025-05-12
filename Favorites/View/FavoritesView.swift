//
//  FavoritesView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: TrendingMoviesListViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.favoriteMovies) { movie in
                NavigationLink(destination: {
                    MovieDetailsView(id: movie.id)
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
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.loadFavorites()
            }
        }
    }
}

#Preview {
    FavoritesView(viewModel: TrendingMoviesListViewModel())
}
