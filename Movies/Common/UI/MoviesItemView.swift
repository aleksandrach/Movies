//
//  MoviesItemView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI
import Kingfisher
import MovieModels

struct MovieItemView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager<Movie>
    
    var movie: Movie
    
    var body: some View {
        HStack {
            KFImage.url(movie.image)
                .placeholder({
                    Rectangle()
                        .fill(.thinMaterial)
                })
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 120)
                .clipped()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(movie.title)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        favoritesManager.toggleFavorite(movie)
                    } label: {
                        FavoriteImage(favorite: favoritesManager.contains(movie))
                    }
                }
                
                Text(movie.overview)
                    .foregroundStyle(.gray)
                    .lineLimit(3)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MovieItemView(movie: Movie(id: 1151039,
                               title: "Nonnas",
                               overview: "After losing his beloved mother, a man risks everything to honor her by opening an Italian restaurant with actual nonnas — grandmothers — as the chefs.",
                               posterPath: "/lZEOKj5wtgUGpaQkzJRl7cjEv21.jpg",
                               releaseDate: ""))
}
