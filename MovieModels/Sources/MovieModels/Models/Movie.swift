//
//  Movie.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

public struct Movie: Identifiable, Codable, Favoritable, Equatable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String?
    public let releaseDate: String
    
    public init(id: Int, title: String, overview: String, posterPath: String?, releaseDate: String) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
    
    public var image: URL? {
        URL(string: APIEndpoints.imageURL + (posterPath ?? ""))
    }
    
    public var releaseYear: String {
        DateFormatter.yearString(from: releaseDate) ?? "N/A"
    }
}
