//
//  ArticleSearchViewModel.swift
//  SwiftUI_NewsApp
//
//  Created by AMAR on 25/07/24.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    @Published var history = [String]()
    2:24:03
    
    private let newsAPI = NewsAPI.shared
    
    
    func searchArticle() async {
        if Task.isCancelled { return }
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsAPI.serach(for: searchQuery)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch{
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
}
