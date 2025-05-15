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
    func testToggleFavoriteTitanicMovie() throws {
        let app = XCUIApplication()
        app.launch()

        let movieId = 597
        let searchId = "search_movie_titanic_\(movieId)"
        let favoritesId = "favorites_movie_titanic_\(movieId)"

        // Step 1: Ensure Titanic is favorited
        app.buttons["Favorites"].tap()
        if app.buttons[favoritesId].waitForExistence(timeout: 2) {
            app.buttons[favoritesId].tap()
            let unfavButton = app.buttons["favorite_button"]
            if unfavButton.waitForExistence(timeout: 2) {
                unfavButton.tap() // Unfavorite it to start fresh
                app.navigationBars.buttons.firstMatch.tap()
            }
        }

        // Step 2: Search and favorite Titanic
        app.buttons["Search"].tap()
        let searchField = app.searchFields["Search movies..."]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        searchField.tap()
        searchField.typeText("Titanic")

        let titanicCell = app.buttons[searchId]
        XCTAssertTrue(titanicCell.waitForExistence(timeout: 5), "Titanic movie should appear")
        titanicCell.tap()

        let favButton = app.buttons["favorite_button"]
        XCTAssertTrue(favButton.waitForExistence(timeout: 5), "Favorite button should be visible")
        favButton.tap()

        // Step 3: Go to Favorites and confirm it’s there
        app.buttons["Favorites"].tap()
        let favoritedCell = app.buttons[favoritesId]
        XCTAssertTrue(favoritedCell.waitForExistence(timeout: 5), "Titanic should be in Favorites")

        // Step 4: Unfavorite it again from Favorites
        favoritedCell.tap()
        let unfavButton = app.buttons["favorite_button"]
        XCTAssertTrue(unfavButton.waitForExistence(timeout: 2))
        unfavButton.tap()

        // Step 5: Confirm it disappears from Favorites
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertFalse(app.buttons[favoritesId].waitForExistence(timeout: 3), "Titanic should be removed from Favorites")
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
