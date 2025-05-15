//
//  Favorites.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

public protocol Favoritable: Identifiable, Codable, Equatable {
    var id: Int { get }
}

import Foundation
import Combine

public final class FavoritesManager<T: Favoritable>: ObservableObject {
    @Published public private(set) var favorites: [T] = []

    private let key: String

    public init(key: String) {
        self.key = key
        loadFavorites()
    }

    public func toggleFavorite(_ item: T) {
        if let index = favorites.firstIndex(of: item) {
            favorites.remove(at: index)
        } else {
            favorites.append(item)
        }
        saveFavorites()
    }

    public func contains(_ item: T) -> Bool {
        favorites.contains(item)
    }

    public func getFavorites() -> [T] {
        return favorites
    }

    private func saveFavorites() {
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Failed to save favorites: \(error)")
        }
    }

    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        do {
            favorites = try JSONDecoder().decode([T].self, from: data)
        } catch {
            print("Failed to load favorites: \(error)")
        }
    }
}
