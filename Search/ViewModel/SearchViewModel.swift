//
//  SearchViewModel.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class SearchViewModel: ObservableObject {
    @Published var isSearching = false
    @Published var searchText: String = ""
    @Published var searchResults: [Movie] = []
    @Published var errorMessage: String? = nil
    
    private var currentPage = 1
    private var totalPages = 1
    private var isFetching = false
    private var cancellables = Set<AnyCancellable>()
    private let service = MovieAPIService.shared
    
    init() {
        observeSearchText()
    }
    
    private func observeSearchText() {
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                print("Searching for:", query) // <-- debug log
                Task {
                    await self?.searchMovies(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    func searchMovies(query: String, page: Int = 1) async {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            searchResults = []
            return
        }
        
        guard !isFetching else { return }
        isFetching = true
        
        do {
            let response = try await service.searchMovies(query: query, page: page)
            
            if page == 1 {
                searchResults = response.results
            } else {
                searchResults.append(contentsOf: response.results)
            }
            
            currentPage = response.page
            totalPages = response.totalPages
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isFetching = false
    }
    
    func loadMoreIfNeeded(currentItem: Movie) async {
        guard !isFetching,
              currentPage < totalPages,
              let lastItem = searchResults.last,
              lastItem.id == currentItem.id else {
            return
        }
        
        await searchMovies(query: searchText, page: currentPage + 1)
    }
}
