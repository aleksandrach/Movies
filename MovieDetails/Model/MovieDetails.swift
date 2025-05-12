//
//  MovieDetails.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

struct MovieDetails: Identifiable, Codable {
    let id: Int
    let genres: [Genre]
    let originalTitle: String
    let overview: String
    let posterPath: String
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    
    var image: URL? {
        URL(string: MoviesAPIEndpoints.imageServerAddress + posterPath)
    }
}

struct Genre: Identifiable, Codable {
    let id: Int
    let name: String
}
