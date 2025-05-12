//
//  SearchMoviesView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

struct SearchMoviesView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.searchResults) { movie in
                NavigationLink(destination: {
                    MovieDetailsView(id: movie.id)
                }) {
                    MovieItemView(movie: movie)
                        .onAppear {
                            Task {
                                await viewModel.loadMoreIfNeeded(currentItem: movie)
                            }
                        }
                }
            }
            .listStyle(.plain)
            .padding(.vertical)
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchText, prompt: "Search movies...")
        }
    }
}

#Preview {
    SearchMoviesView()
}
