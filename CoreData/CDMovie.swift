//
//  CDMovie.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 13.5.25.
//

import Foundation
import CoreData

@objc(CDMovie)
public class CDMovie: NSManagedObject {}

extension CDMovie {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var overview: String
    @NSManaged public var posterPath: String
    @NSManaged public var releaseDate: String
}

extension CDMovie {
    func toMovie() -> Movie {
        Movie(
            id: Int(id),
            title: title,
            overview: overview,
            posterPath: posterPath,
            releaseDate: releaseDate
        )
    }

    func update(from movie: Movie) {
        self.id = Int64(movie.id)
        self.title = movie.title
        self.overview = movie.overview
        self.posterPath = movie.posterPath ?? ""
        self.releaseDate = movie.releaseDate
    }
}
