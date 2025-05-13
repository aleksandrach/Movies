//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    @StateObject private var viewModel = MovieDetailsViewModel()
    @EnvironmentObject var favoritesManager: FavoritesManager<Movie>
    
    var id: Int
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 8) {
                    HStack {
                        Text(viewModel.movieDetails?.releaseYear ?? "")
                        
                        Text("\(viewModel.movieDetails?.formattedRuntime ?? "")")
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    KFImage(viewModel.movieDetails?.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                    
                    if let movieDetails = viewModel.movieDetails {
                        GenreTagsView(genres: movieDetails.genres)
                    }
                    
                    HStack {
                        if let movieDetails = viewModel.movieDetails {
                            RatingView(movieDetails: movieDetails)
                            
                            Text(viewModel.movieDetails?.overview ?? "N/A")
                                .padding(4)
                        }
                    }
                }
            }
            .navigationTitle(viewModel.movieDetails?.title ?? "")
            .toolbar {
                if let movieDetails = viewModel.movieDetails {
                    Button {
                        favoritesManager.toggleFavorite(movieDetails.asMovie)
                    } label: {
                        if favoritesManager.contains(movieDetails.asMovie) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundStyle(.yellow)
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.getMovieDetails(movieId: id)
                }
            }
        }
    }
}

struct GenreTagsView: View {
    let genres: [Genre]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres) { genre in
                    Text(genre.name)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.white)
                        .clipShape(Rectangle())
                }
            }
        }
    }
}

struct RatingView: View {
    let movieDetails: MovieDetails
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                
                Text(String(format: "%.1f", movieDetails.voteAverage) + "/10")
                    .font(.headline)
                
                Text("\(String(describing: movieDetails.voteCount))")
                    .font(.caption)
            }
        }
        .padding(.horizontal)
    }
}
