//
//  Favorites.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation
import CoreData
import Combine

public final class FavoritesManager: ObservableObject {
    @Published public private(set) var favorites: [CDMovie] = []

    private let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext) {
        self.context = context
        loadFavorites()
    }

    public func toggleFavorite(movie: Movie) {
        // Fetch the CDMovie with the given movie.id or create it if not found
        let fetchRequest: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)

        do {
            let results = try context.fetch(fetchRequest)
            let cdMovie: CDMovie

            if let existing = results.first {
                cdMovie = existing
                // Toggle the isFavorite flag
                cdMovie.isFavorite.toggle()
            } else {
                // Create new CDMovie if not found
                cdMovie = CDMovie(context: context)
                cdMovie.id = Int64(movie.id)
                cdMovie.title = movie.title
                cdMovie.overview = movie.overview
                cdMovie.posterPath = movie.posterPath ?? ""
                cdMovie.releaseDate = movie.releaseDate
                cdMovie.isFavorite = true // since user just favorited it
            }

            saveContext()
            loadFavorites()

        } catch {
            print("Failed to fetch or update CDMovie: \(error)")
        }
    }

    public func isFavorite(movie: Movie) -> Bool {
        favorites.contains(where: { $0.id == movie.id && $0.isFavorite })
    }

    private func loadFavorites() {
        let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        // Load only movies marked as favorites
        request.predicate = NSPredicate(format: "isFavorite == YES")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDMovie.title, ascending: true)]

        do {
            favorites = try context.fetch(request)
        } catch {
            print("Failed to fetch favorites: \(error)")
            favorites = []
        }
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

extension FavoritesManager {
    public var favoriteMovies: [Movie] {
        favorites.map { cdMovie in
            Movie(
                id: Int(cdMovie.id),
                title: cdMovie.title,
                overview: cdMovie.overview,
                posterPath: cdMovie.posterPath,
                releaseDate: cdMovie.releaseDate
            )
        }
    }
}
