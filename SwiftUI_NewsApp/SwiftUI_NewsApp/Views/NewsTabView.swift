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
                .task(id: articaleNewsVM.fetchTaskToken, loadTask)
                .refreshable(action: refershTask)
//                   loadTask()
//                }
//                .onAppear {
//                    loadTask()
//                }
//                .onChange(of: articaleNewsVM.selectedCategory, perform: { _ in
//                    loadTask()
//                })
                .navigationTitle(articaleNewsVM.fetchTaskToken.category.text)
                .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articaleNewsVM.phase {
        case .empty:
             ProgressView()
        case .success(let articles) where articles.isEmpty:   EmptyPlaceholderView(text: "No Articles", image: nil)
        case .failure(let error):
             RetryView(text: error.localizedDescription, retryAction: refershTask)
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
    
    private func loadTask() async{
        await articaleNewsVM.loadArticles()
    }
    
    private func refershTask(){
        articaleNewsVM.fetchTaskToken = FetchTaskToken(category: articaleNewsVM.fetchTaskToken.category, token: Date())
    }
    
    private var menu: some View {
        Menu {
            Picker("Category", selection: $articaleNewsVM.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }
    }
}


#Preview {
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    NewsTabView(articaleNewsVM: ArticleNewsViewModel(articles: Article.previewData))
        .environmentObject(articleBookmarkVM)
}

