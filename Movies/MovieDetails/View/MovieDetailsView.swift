//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI
import Kingfisher
import MovieModels

struct MovieDetailsView: View {
    @StateObject private var viewModel = MovieDetailsViewModel()
    @EnvironmentObject var favoritesManager: FavoritesManager<Movie>
    
    // It seems that here is some Apple bug, if you set the navTitle like this: .navigationTitle(viewModel.movieDetails?.title ?? " "), it will show "" on the screen - so added computed property
    var navigationTitle: String {
        if let title = viewModel.movieDetails?.title {
            return title
        } else {
            return ""
        }
    }
    
    var id: Int
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 8) {
                    HStack {
                        Text(viewModel.movieDetails?.releaseYear ?? "")
                        
                        Text("\(viewModel.movieDetails?.formattedRuntime ?? "")")
                        
                        Spacer()
                        
                        if let movieDetails = viewModel.movieDetails {
                            RatingView(movieDetails: movieDetails)
                        }
                    }
                    .padding(.horizontal)
                    
                    KFImage.url(viewModel.movieDetails?.image)
                        .placeholder({
                            Rectangle()
                                .fill(.thinMaterial)
                        })
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 9 / 16) // Aspect ratio 16:9
                        .clipped()
                    
                    if let movieDetails = viewModel.movieDetails {
                        GenreTagsView(genres: movieDetails.genres)
                            .padding(.horizontal)
                    }
                    
                    Text(viewModel.movieDetails?.overview ?? "")
                        .padding(4)
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                if let movieDetails = viewModel.movieDetails {
                    Button {
                        favoritesManager.toggleFavorite(movieDetails.asMovie)
                    } label: {
                        FavoriteImage(favorite: favoritesManager.contains(movieDetails.asMovie))
                    }
                    .accessibilityIdentifier("favorite_button")
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
                        .background(Color.gray.opacity(0.5))
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
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
            
            VStack {
                Text(String(format: "%.1f", movieDetails.voteAverage) + "/10")
                    .font(.headline)
                
                Text("\(String(describing: movieDetails.voteCount))")
                    .font(.caption)
            }
        }
        .padding(.horizontal)
    }
}
