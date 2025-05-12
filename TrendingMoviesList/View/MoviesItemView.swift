//
//  MoviesItemView.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import SwiftUI
import Kingfisher

struct MovieItemView: View {
    var movie: Movie
    
    var body: some View {
        HStack {
            KFImage(movie.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 120)
                .clipped()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(movie.title)
                        .font(.headline)
                    
                    Spacer()
                }
                
                Text(movie.overview)
                    .lineLimit(3)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MovieItemView(movie: Movie(id: 1151039,
                               title: "Nonnas",
                               originalTitle: "Nonnas",
                               overview: "After losing his beloved mother, a man risks everything to honor her by opening an Italian restaurant with actual nonnas — grandmothers — as the chefs.",
                               posterPath: "/lZEOKj5wtgUGpaQkzJRl7cjEv21.jpg",
                               popularity: 52.8025,
                               releaseDate: "2025-05-01",
                               voteAverage: 6.308,
                               voteCount: 13))
}
