//
//  FavoriteImage.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 15.5.25.
//

import SwiftUI

struct FavoriteImage: View {
    var favorite: Bool
    
    var body: some View {
        Image(systemName: favorite ? "star.fill" : "star")
            .foregroundStyle(.yellow)
    }
}
