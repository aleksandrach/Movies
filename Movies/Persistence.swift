//
//  Persistence.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import CoreData
import MovieModels

struct PersistenceController {
    static let shared = PersistenceController()
    
    // MARK: - Preview/Test Support
        static var preview: PersistenceController = {
            let controller = PersistenceController(inMemory: true)

            // Optionally, preload mock data
            let viewContext = controller.container.viewContext
            let sampleMovie = CDMovie(context: viewContext)
            sampleMovie.id = 1
            sampleMovie.title = "Sample Movie"
            sampleMovie.overview = "This is a preview movie used for SwiftUI previews."
            sampleMovie.posterPath = "/sample.jpg"

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }

            return controller
        }()

    @MainActor

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Movies")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
