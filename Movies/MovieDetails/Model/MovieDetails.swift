//
//  MovieDetails.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

struct MovieDetails: Identifiable, Codable, Favoritable, Equatable {
    let id: Int
    let genres: [Genre]
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int
    
    var image: URL? {
        URL(string: APIEndpoints.imageURL + (posterPath ?? ""))
    }
    
    var releaseYear: String {
        DateFormatter.yearString(from: releaseDate) ?? "N/A"
    }
    
    var formattedRuntime: String {
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }
}

extension MovieDetails {
    var asMovie: Movie {
        Movie(
            id: self.id,
            title: self.title,
            overview: self.overview,
            posterPath: self.posterPath,
            releaseDate: self.releaseDate
        )
    }
}

struct Genre: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
}
