//
//  Movie.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

struct Movie: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String
    let popularity: Double
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
}
