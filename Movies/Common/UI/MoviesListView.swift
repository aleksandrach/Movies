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
    
    var body: some View {
        NavigationStack {
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
                .accessibilityIdentifier("movie_\(movie.title.replacingOccurrences(of: " ", with: "_").lowercased())")
            }
            .listStyle(.plain)
            .navigationTitle(title)
            .onAppear {
                onAppear?()
            }
        }
    }
}
