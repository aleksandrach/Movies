//
//  MoviesListView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 13.5.25.
//

import SwiftUI

struct MoviesListView: View {
    let movies: [Movie]
    let title: String
    let onItemAppear: ((Movie) -> Void)?
    let onAppear: (() -> Void)?
    var showEmptyState: (() -> Bool)? = nil
    let accessibilityPrefix: String // e.g. "search" or "favorites"
    
    var body: some View {
        NavigationStack {
            if movies.isEmpty && (showEmptyState?() ?? true) {
                // Show a placeholder view when there are no movies
                ContentUnavailableView("No Movies",
                                       systemImage: "film",
                                       description: Text("There are no movies to display right now."))
                .navigationTitle(title)
                .onAppear {
                    onAppear?()
                }
            } else {
                List(movies) { movie in
                    NavigationLink(
                        destination: MovieDetailsView(id: movie.id),
                        label: {
                            MovieItemView(movie: movie)
                                .onAppear {
                                    onItemAppear?(movie)
                                }
                        }
                    )
                    .accessibilityIdentifier("\(accessibilityPrefix)_movie_\(movie.title.replacingOccurrences(of: " ", with: "_").lowercased())_\(movie.id)")
                }
                .listStyle(.plain)
                .navigationTitle(title)
                .onAppear {
                    onAppear?()
                }
            }
        }
    }
}
