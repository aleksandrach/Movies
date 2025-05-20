//
//  SearchMoviesViewModel.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 12.5.25.
//

import Foundation
import Combine
import SwiftUI
import MovieModels

enum SearchMode: String, CaseIterable, Identifiable {
    case movies = "Movies"
    case tvShows = "TV Shows"
    
    var id: String { self.rawValue }
}

@MainActor
class SearchMoviesViewModel: ObservableObject {
    @Published var isSearching = false
    @Published var searchText: String = ""
    @Published var searchResults: [Movie] = []
    @Published var errorMessage: String?
    @Published var searchMode = SearchMode.movies {
        didSet {
            resetSearchResults()
        }
    }
    
    
    private var currentPage = 1
    private var totalPages = 1
    private var isFetching = false
    private var cancellables = Set<AnyCancellable>()
    private let service = APIService.shared
    private let repository: MovieRepository
    
    init(repository: MovieRepository = CoreDataMovieRepository()) {
        self.repository = repository
        
        observeSearchText()
    }
    
    private func observeSearchText() {
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                Task {
                    await self?.searchMovies(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    func searchMovies(query: String, page: Int = 1) async {
        guard query.count > 2 else {
            searchResults = []
            return
        }
        
//        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
//            searchResults = []
//            return
//        }
        
        guard !isFetching else { return }
        isFetching = true
        
        do {
            let response: SearchMoviesResponse
            
            switch searchMode {
            case .movies:
                response = try await service.searchMovies(query: query, page: page)
            case .tvShows:
                response = try await service.searchTVShows(query: query, page: page)
            }
            
            if page == 1 {
                searchResults = response.results
                
                repository.saveMovies(searchResults)
            } else {
                searchResults.append(contentsOf: response.results)
            }
            
            currentPage = response.page
            totalPages = response.totalPages
        } catch {
            errorMessage = error.localizedDescription
            
            if page == 1 {
                searchResults = repository.fetchCachedMovies(query: query)
            }
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
    
    func resetSearchResults() {
        isFetching = false
        searchText = ""
    }
}
