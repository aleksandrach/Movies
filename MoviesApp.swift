//
//  MoviesApp.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI

@main
struct MoviesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MoviesListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
