//
//  MoviesAPIEndpoints.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation

enum APIEndpoints {
    static let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDBjZGY0ZjE1ZWJlZTA3MjA1NTNmN2NkN2YyMmRhZiIsIm5iZiI6MTc0NjgxNjU1NC4xMjksInN1YiI6IjY4MWU0ZTJhMGY3MzM5MDQwNjljMmJiNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UaZpGO0iTbk5_pdg8DPm_hZac9ddPiMMpP1EpKrso9k"
    
    static let trendingMovies = AppEnvironment.current.baseURL + "trending/movie/week"
    
    static let movieDetails = AppEnvironment.current.baseURL + "movie/"
    
    static let searchMovies = AppEnvironment.current.baseURL + "search/movie"
    
    static let imageURL = "https://image.tmdb.org/t/p/w500/"
}
