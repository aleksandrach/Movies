//
//  MoviesApp.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

@main
struct MoviesApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var movieFavoritesManager = FavoritesManager<Movie>(key: "FavoriteMovies")
    
    var body: some Scene {
        WindowGroup {
            TabView {
                TrendingMoviesView()
                    .tabItem {
                        Label("Trending", systemImage: "chart.line.uptrend.xyaxis")
                    }
                
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                
                SearchMoviesView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                AboutScreen()
                    .tabItem {
                        Label("About", systemImage: "info.circle")
                    }
            }
            .environmentObject(movieFavoritesManager)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
