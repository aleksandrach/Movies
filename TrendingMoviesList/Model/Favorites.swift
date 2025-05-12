//
//  Favorites.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual movies the user has favorited
    private var favoriteIDs: Set<String>
    
    // the key we're using to read/write in UserDefaults
    private let key = "Favorites"
    
    static let shared = Favorites()
    
    init() {
        // load our saved data
        if let saved = UserDefaults.standard.array(forKey: key) as? [String] {
            self.favoriteIDs = Set(saved)
        } else {
            self.favoriteIDs = []
        }
    }

    // returns true if our set contains this movie
    func contains(_ movie: Movie) -> Bool {
        favoriteIDs.contains(String(movie.id))
    }
    
    func toggleFavorite(_ movie: Movie) {
        if contains(movie) {
            remove(movie)
        } else {
            add(movie)
        }
    }
    
    // adds the movie to our set and saves the change
    func add(_ movie: Movie) {
        favoriteIDs.insert(String(movie.id))
        
        UserDefaults.standard.set(Array(favoriteIDs), forKey: key)
        objectWillChange.send()
    }
    
    // removes the movie from our set and saves the change
    func remove(_ movie: Movie) {
        favoriteIDs.remove(String(movie.id))
        
        UserDefaults.standard.set(Array(favoriteIDs), forKey: key)
        objectWillChange.send()
    }
}
