//
//  FavoritesViewModel.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favoriteMovies: [Movie] = []

    @ObservedObject var favorites = FavoritesManager.shared
    
    private var cancellables = Set<AnyCancellable>()
    
//    func loadFavorites() {
//        self.favoriteMovies = movies.filter { favorites.contains($0) }
//    }
}
