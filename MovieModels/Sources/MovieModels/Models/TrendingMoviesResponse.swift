//
//  TrendingMoviesResponse.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

public struct TrendingMoviesResponse: Codable {
    public let page: Int
    public let results: [Movie]
    public let totalPages: Int
    public let totalResults: Int
}
