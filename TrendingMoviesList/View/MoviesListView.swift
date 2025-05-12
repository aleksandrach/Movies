//
//  MoviesListView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: TrendingMoviesListViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                NavigationLink(destination: {
                    MovieDetailsView(id: movie.id)
                }) {
                    MovieItemView(movie: movie)
                        .onAppear {
                            Task {
                                await viewModel.loadMoreMoviesIfNeeded(movies: viewModel.movies, currentItem: movie)
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
    MoviesListView(viewModel: TrendingMoviesListViewModel())
}
