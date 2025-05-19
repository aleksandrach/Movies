//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import XCTest
import SwiftUI
@testable import Movies
import MovieModels

final class MoviesTests: XCTestCase {
    let service = APIService.shared
    
    var favoritesManager: FavoritesManager!

    @MainActor
    override func setUpWithError() throws {
        favoritesManager = FavoritesManager(context: PersistenceController.shared.container.viewContext)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Tests for asMovie (MovieDetails -> Movie)
    
    func testMovieDetailsToMovieSuccess() {
        let movieDetails = MovieDetails(id: 1,
                                        genres: [
                                            Genre(id: 28, name: "Action"),
                                            Genre(id: 878, name: "Science Fiction"),
                                            Genre(id: 12, name: "Adventure")
                                            ],
                                        title: "Test Movie",
                                        overview: "Overview",
                                        posterPath: "/test.jpg",
                                        releaseDate: "2025-01-01",
                                        voteAverage: 7.52,
                                        voteCount: 16,
                                        runtime: 126)
        
        
        XCTAssertTrue(movieDetails.asMovie is Movie)
    }
    
    // Test the transformation of MovieDetails to Movie
    func testAsMovie() {
        // Create a MovieDetails instance
        let movieDetails = MovieDetails(id: 1,
                                        genres: [
                                            Genre(id: 28, name: "Action"),
                                            Genre(id: 878, name: "Science Fiction"),
                                            Genre(id: 12, name: "Adventure")
                                        ],
                                        title: "Test Movie",
                                        overview: "Overview",
                                        posterPath: "/test.jpg",
                                        releaseDate: "2025-01-01",
                                        voteAverage: 7.52,
                                        voteCount: 16,
                                        runtime: 126)
        
        // Get the corresponding Movie using the asMovie computed property
        let movie = movieDetails.asMovie
        
        // Assert that the properties match
        XCTAssertEqual(movie.id, movieDetails.id, "Movie ID should match MovieDetails ID")
        XCTAssertEqual(movie.title, movieDetails.title, "Movie title should match MovieDetails title")
        XCTAssertEqual(movie.overview, movieDetails.overview, "Movie overview should match MovieDetails overview")
        XCTAssertEqual(movie.posterPath, movieDetails.posterPath, "Movie posterPath should match MovieDetails posterPath")
        XCTAssertEqual(movie.releaseDate, movieDetails.releaseDate, "Movie releaseDate should match MovieDetails releaseDate")
    }
    
    // MARK: Search tests
    func testSearchMoviesSuccess() async {
        let expectation = XCTestExpectation(description: "Search movies succeeds")
        
        do {
            let movies = try await APIService.shared.searchMovies(query: "Inception", page: 1)
            XCTAssertFalse(movies.results.isEmpty, "Expected non-empty search results")
            expectation.fulfill()
        } catch {
            XCTFail("Search failed with error: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func testSearchMoviesFailure() async {
        let expectation = XCTestExpectation(description: "Search movies fail for empty query")
        
        do {
            let _ =  try await service.searchMovies(query: "", page: 0)
            XCTFail("Should fail for empty query")
        } catch {
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    // MARK: Favorites tests
    func testAddFavoriteSucceeds() {
        let movie = Movie(
            id: 1,
            title: "Test Movie",
            overview: "Overview",
            posterPath: "/test.jpg",
            releaseDate: "2025-01-01"
        )
        
        favoritesManager.toggleFavorite(movie: movie)
        
        XCTAssertTrue(favoritesManager.isFavorite(movie: movie))
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
