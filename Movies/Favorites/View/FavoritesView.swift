//
//  FavoritesView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI
import MovieModels

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager<Movie>
    
    var body: some View {
        MoviesListView(movies: favoritesManager.favorites,
                       title: "Favorites",
                       onItemAppear: nil,
                       onAppear: nil,
                       showEmptyState: {
            // Always show empty view if favorites list is empty
            true
        }, accessibilityPrefix: "favorites")
    }
}

#Preview {
    FavoritesView()
}
