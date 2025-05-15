//
//  FavoritesView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager<Movie>
    
    var body: some View {
        MoviesListView(movies: favoritesManager.favorites,
                       title: "Favorites",
                       onItemAppear: nil,
                       onAppear: nil,
                       accessibilityPrefix: "favorites")
    }
}

#Preview {
    FavoritesView()
}
