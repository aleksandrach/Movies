//
//  MoviesApp.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI
import MovieModels

@main
struct MoviesApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var favoritesManager: FavoritesManager
    
    init() {
        let context = persistenceController.container.viewContext
        _favoritesManager = StateObject(wrappedValue: FavoritesManager(context: context))
    }
    
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
            .environmentObject(favoritesManager)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
