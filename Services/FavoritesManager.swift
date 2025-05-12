//
//  Favorites.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

protocol Favoritable: Identifiable {
    var id: Int { get }
}

class FavoritesManager: ObservableObject {
    // the actual movies the user has favorited
    private var favoriteIDs: Set<String>
    
    // the key we're using to read/write in UserDefaults
    private let key = "Favorites"
    
    static let shared = FavoritesManager()
    
    init() {
        // load our saved data
        if let saved = UserDefaults.standard.array(forKey: key) as? [String] {
            self.favoriteIDs = Set(saved)
        } else {
            self.favoriteIDs = []
        }
    }

    // returns true if our set contains this movie
    func contains<T: Favoritable>(_ item: T) -> Bool {
        favoriteIDs.contains(String(item.id))
    }
    
    func toggle<T: Favoritable>(_ item: T) {
        if contains(item) {
            remove(item)
        } else {
            add(item)
        }
    }
    
    // adds the movie to our set and saves the change
    func add<T: Favoritable>(_ item: T) {
        favoriteIDs.insert(String(item.id))
        
        UserDefaults.standard.set(Array(favoriteIDs), forKey: key)
        objectWillChange.send()
    }
    
    // removes the movie from our set and saves the change
    func remove<T: Favoritable>(_ item: T) {
        favoriteIDs.remove(String(item.id))
        
        UserDefaults.standard.set(Array(favoriteIDs), forKey: key)
        objectWillChange.send()
    }
}
