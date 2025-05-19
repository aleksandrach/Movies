//
//  MovieDetails.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

public struct MovieDetails: Identifiable, Codable, Equatable {
    public let id: Int
    public let genres: [Genre]
    public let title: String
    public let overview: String
    public let posterPath: String?
    public let releaseDate: String
    public let voteAverage: Double
    public let voteCount: Int
    public let runtime: Int
    
    public var image: URL? {
        URL(string: APIEndpoints.imageURL + (posterPath ?? ""))
    }
    
    public var releaseYear: String {
        DateFormatter.yearString(from: releaseDate) ?? "N/A"
    }
    
    public var formattedRuntime: String {
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }
    
    public init(id: Int, genres: [Genre], title: String, overview: String, posterPath: String?, releaseDate: String, voteAverage: Double, voteCount: Int, runtime: Int) {
        self.id = id
        self.genres = genres
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.runtime = runtime
    }
}

extension MovieDetails {
    public var asMovie: Movie {
        Movie(
            id: self.id,
            title: self.title,
            overview: self.overview,
            posterPath: self.posterPath,
            releaseDate: self.releaseDate
        )
    }
}

public struct Genre: Identifiable, Codable, Equatable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
