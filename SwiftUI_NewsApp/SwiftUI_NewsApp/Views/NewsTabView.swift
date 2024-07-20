//
//  NewsTabView.swift
//  SwiftUI_NewsApp
//
//  Created by AMAR on 19/07/24.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var articaleNewsVM = ArticleNewsViewModel()
    var body: some View {
        NavigationView{
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .refreshable {
                    
                }
                .onAppear {
                    async {
                        await articaleNewsVM.loadArticles()
                    }
                }
                .navigationTitle(articaleNewsVM.selectedCategory.text)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articaleNewsVM.phase {
        case .empty:
             ProgressView()
        case .success(let articles) where articles.isEmpty:   EmptyPlaceholderView(text: "No Articles", image: nil)
        case .failure(let error):
             RetryView(text: error.localizedDescription) {
                // TODO : Refresh the news API
            }
        default:
            EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = articaleNewsVM.phase{
            return articles
        } else {
            return []
        }
    }
}


#Preview {
    NewsTabView(articaleNewsVM: ArticleNewsViewModel(articles: Article.previewData))
}

