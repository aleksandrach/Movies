//
//  SearchMoviesView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

struct SearchMoviesView: View {
    @StateObject private var viewModel = SearchMoviesViewModel()
    
    var body: some View {
        MoviesListView(movies: viewModel.searchResults,
                       title: "Search",
                       onItemAppear: { movie in
            Task {
                await viewModel.loadMoreIfNeeded(currentItem: movie)
            }
        }, onAppear: nil,
                       accessibilityPrefix: "search")
        .searchable(text: $viewModel.searchText, prompt: "Search movies...")
    }
}

#Preview {
    SearchMoviesView()
}
