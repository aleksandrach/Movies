//
//  MoviesListView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject private var viewModel = TrendingMoviesListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                NavigationLink(destination: {
                    
                }) {
                    MovieItemView(movie: movie)
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
    MoviesListView()
}
