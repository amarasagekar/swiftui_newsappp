//
//  ContentView.swift
//  SwiftUI_NewsApp
//
//  Created by AMAR on 15/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTabView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
        }
//        ArticleListView(articles: Article.previewData)
    }
}

#Preview {
    ContentView()
}
