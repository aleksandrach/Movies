//
//  MovieRepository.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 13.5.25.
//

import Foundation
import CoreData

// MARK: - Protocol

public protocol MovieRepository {
    func saveMovies(_ movies: [Movie])
    func fetchCachedMovies() -> [Movie]
    func fetchCachedMovies(query: String?) -> [Movie]
}

public final class CoreDataMovieRepository: MovieRepository {
    private let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    // MARK: - Core Data Saving

    public func saveMovies(_ movies: [Movie]) {
        for movie in movies {
            let fetchRequest: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)

            if let existing = try? context.fetch(fetchRequest).first {
                existing.title = movie.title
                existing.overview = movie.overview
                existing.posterPath = movie.posterPath ?? ""
                existing.releaseDate = movie.releaseDate
            } else {
                let newMovie = CDMovie(context: context)
                newMovie.id = Int64(movie.id)
                newMovie.title = movie.title
                newMovie.overview = movie.overview
                newMovie.posterPath = movie.posterPath ?? ""
                newMovie.releaseDate = movie.releaseDate
            }
        }

        do {
            try context.save()
        } catch {
            print("Error saving movies to Core Data: \(error)")
        }
    }

    // MARK: - Core Data Fetching

    public func fetchCachedMovies() -> [Movie] {
        let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        do {
            let cdMovies = try context.fetch(request)
            return cdMovies.map { $0.toMovie() }
        } catch {
            print("Error fetching cached movies: \(error)")
            return []
        }
    }
    
    public func fetchCachedMovies(query: String? = nil) -> [Movie] {
        let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()

        if let query = query, !query.isEmpty {
            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", query)
            request.predicate = predicate
        }

        do {
            let results = try context.fetch(request)
            return results.map { $0.toMovie() }
        } catch {
            print("Error fetching cached movies: \(error)")
            return []
        }
    }
}
