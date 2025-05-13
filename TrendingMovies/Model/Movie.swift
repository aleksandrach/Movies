//
//  Movie.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

struct Movie: Identifiable, Codable, Favoritable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    
    var image: URL? {
        URL(string: APIEndpoints.imageURL + (posterPath ?? ""))
    }
    
    var releaseYear: String {
        DateFormatter.yearString(from: releaseDate) ?? "N/A"
    }
}
