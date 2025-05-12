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
    
    @ObservedObject var favorites = FavoritesManager.shared
    
    var id: Int
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    KFImage(viewModel.movieDetails?.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                    
                    HStack {
                        VStack {
                            Text(String(format: "%.1f", viewModel.movieDetails?.voteAverage ?? "N/A") + "/10")
                                .font(.headline)
                            
                            Text("\(String(describing: viewModel.movieDetails?.voteCount))")
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        Text(viewModel.movieDetails?.releaseYear ?? "N/A")
                    }
                    .padding(.horizontal)
                    
                    Text(viewModel.movieDetails?.overview ?? "N/A")
                        .padding(4)
                }
            }
            .navigationTitle(viewModel.movieDetails?.title ?? "")
            .toolbar {
                if let movieDetails = viewModel.movieDetails {
                    Button {
                        favorites.toggle(movieDetails)
                    } label: {
                        if favorites.contains(movieDetails) {
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

