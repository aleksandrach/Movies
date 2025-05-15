//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import XCTest

final class MoviesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func testSearchAndFavoriteTitanicMovie() throws {
        let app = XCUIApplication()
        app.launch()

        // Tap the Search tab
        app.buttons["Search"].tap()

        // Tap and enter "Titanic" in the search field
        let searchField = app.searchFields["Search movies..."]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5), "Search field should exist")
        searchField.tap()
        searchField.typeText("Titanic")

        // Wait for the Titanic result to appear using accessibility identifier
        let movieId = 597
        let movieIdentifier = "search_movie_titanic_\(movieId)"
        let titanicCell = app.buttons[movieIdentifier]

        XCTAssertTrue(titanicCell.waitForExistence(timeout: 5), "Titanic movie cell should exist in Search results")
        titanicCell.tap()

        // Tap the favorite button
        let favoriteButton = app.buttons["favorite_button"]
        XCTAssertTrue(favoriteButton.waitForExistence(timeout: 5), "Favorite button should exist on movie details screen")
        favoriteButton.tap()

        // Navigate to Favorites tab
        app.buttons["Favorites"].tap()

        // Confirm Titanic appears in Favorites
        let favoriteMovieIdentifier = "favorites_movie_titanic_\(movieId)"
        let favoriteMovieCell = app.buttons[favoriteMovieIdentifier]

        XCTAssertTrue(favoriteMovieCell.waitForExistence(timeout: 5), "Titanic movie should appear in Favorites")
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
