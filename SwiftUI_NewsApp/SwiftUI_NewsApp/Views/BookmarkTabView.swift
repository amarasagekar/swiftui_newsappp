//
//  BookmarkTabView.swift
//  SwiftUI_NewsApp
//
//  Created by AMAR on 23/07/24.
//

import SwiftUI

struct BookmarkTabView: View {
    
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articleBookmarkVM.bookmarks)
                .overlay(overlayView(isEmpty: articleBookmarkVM.bookmarks.isEmpty))
                .navigationTitle("Saved Articles")
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No Saved articles", image: Image(systemName: "bookmark"))
        }
    }
}

#Preview {
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    
    BookmarkTabView()
        .environmentObject(articleBookmarkVM)
}

