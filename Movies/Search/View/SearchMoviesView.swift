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
        VStack {
            Picker("", selection: $viewModel.searchMode) {
                ForEach(SearchMode.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            MoviesListView(movies: viewModel.searchResults,
                           title: "Search",
                           onItemAppear: { movie in
                Task {
                    await viewModel.loadMoreIfNeeded(currentItem: movie)
                }
            }, onAppear: nil,
                           showEmptyState: {
                // Show empty only if search text is more than 2 characters
                viewModel.searchText.count > 2
            }, accessibilityPrefix: "search")
            .searchable(text: $viewModel.searchText, prompt: "Search movies...")
        }
    }
}

#Preview {
    SearchMoviesView()
}
